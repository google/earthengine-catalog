# Guide: Ingesting Vector Datasets into BigQuery

[TOC]

## Workflow Overview

The overall process involves four steps:

1.  **Create BigQuery Dataset**: Ensure that BigQuery has a dataset to hold tables.
2.  **Data Preparation**: Convert source data (e.g., Shapefiles) to CSV or
    Parquet with geometries represented as WKT strings. Though Parquet also
    works as an intermediate format, this guide uses CSV for simplicity.
3.  **Upload to Staging**: Load the CSV data into a BigQuery staging (temporary) table
    where geometry is kept as a `STRING`. This avoids load failures caused by
    invalid geometries.
4.  **Finalize Table**: Create the final table by selecting data from the
    staging table into a final table, converting the WKT string column into a `GEOGRAPHY` type.

---

## Step 1: Create BigQuery Dataset

Before uploading, ensure your project has a BigQuery dataset that will contain the tables exists in BigQuery. If it does not, create it using the Cloud Console or by running the following SQL:

```sql
-- Replace 'your_dataset_name' with the desired dataset name
CREATE SCHEMA IF NOT EXISTS `your-project.your_dataset_name`
OPTIONS(location="US");
```

---

## Step 2: Data Preparation

*If your data is already in CSV format with geometry provided in one column as WKT strings, you can skip this step and proceed to Step 3.*

Source data requires conversion to CSV before ingestion if it is currently in another format. The Python script below uses `GeoPandas` to read a shapefile, ensure the projection is `EPSG:4326` (WGS 84), convert geometries to WKT strings, and save the result as a CSV file.

*Note: If you are working with WDPA data that comes in a complex nested-zip format, you can use [this specialized conversion script](wdpa_bigquery_converter.py) instead.*

**Prerequisites:**

Install necessary Python libraries:

```shell
pip install geopandas pyarrow shapely google-cloud-bigquery
```

**Script:**

```python
import geopandas as gpd
import pandas as pd
import os

# --- CONFIGURATION ---
# The path to your shapefile
SHP_PATH = "/path/to/your/shapefile.shp"
# Where you want the final CSV file to be saved
OUTPUT_DIR = "./csv_output"
OUTPUT_FILENAME = "output.csv"

def convert_shp_to_csv(shp_path, output_dir, output_filename):
    """
    Reads a shapefile, reprojects it to EPSG:4326,
    converts geometry to WKT, and saves it as a CSV file.
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    print(f"--- Processing {shp_path} ---")
    try:
        gdf = gpd.read_file(shp_path)
    except Exception as e:
        print(f"Error reading shapefile '{shp_path}': {e}")
        return

    if gdf.empty:
        print(f"Shapefile is empty. Skipping.")
        return

    # 1. Force CRS to WGS84 (BigQuery Requirement for GEOGRAPHY)
    if gdf.crs is None or gdf.crs.to_epsg() != 4326:
        print(f"Reprojecting from {gdf.crs} to EPSG:4326...")
        gdf = gdf.to_crs(epsg=4326)

    # 2. Fix potential column name issues
    # BigQuery columns must be alphanumeric/underscores.
    gdf.columns = [c.replace(' ', '_').replace('-', '_').replace('.', '_') for c in gdf.columns]

    # 3. Convert geometry to WKT string to ensure compatibility
    #    with ST_GEOGFROMTEXT in BigQuery.
    print("Converting geometry to WKT...")
    geom_col = gdf.geometry.name
    df = pd.DataFrame(gdf.copy())

    df["geometry"] = gdf[geom_col].apply(
        lambda x: x.wkt if x is not None and not x.is_empty else None
    )

    if geom_col != "geometry" and geom_col in df.columns:
        df = df.drop(columns=[geom_col])

    # 4. Export to CSV
    out_path = os.path.join(output_dir, output_filename)
    print(f"Writing {out_path}...")
    df.to_csv(out_path, index=False)

    print(f"\nSuccess! CSV file is located at: {os.path.abspath(out_path)}")

if __name__ == "__main__":
    convert_shp_to_csv(SHP_PATH, OUTPUT_DIR, OUTPUT_FILENAME)
```

**Result:** After running the script, your `OUTPUT_DIR` will contain `output.csv`. Proceed to Step 3.

---

## Step 3: Upload CSV Data to BigQuery Staging Table

We first load data into a staging table where the geometry column is treated as a `STRING`. This allows us to handle very large geometry strings and bypass errors during the initial load if some geometries are invalid.

If you generated CSV files in Step 2, or have existing CSV files, upload them to Google Cloud Storage (GCS) and then load them into BigQuery using the `bq` command-line tool.

**3.1. Upload CSV files to GCS:**

Replace `your-bucket-name` with your GCS bucket and `csv_output` with the directory containing your CSV files.

```shell
gcloud storage cp ./csv_output/*.csv gs://your-bucket-name/wdpa_staging_csv/
```

**3.2. Load data from GCS into BigQuery:**

This command loads all CSV files from the GCS path into `your_dataset_name.staging_table`, replacing the table if it exists. BigQuery will attempt to infer the schema from the CSV files.

```shell
bq --location=US load --replace \
  --source_format=CSV \
  --autodetect=true \
  --allow_quoted_newlines=true \
  your-project:your_dataset_name.staging_table \
  "gs://your-bucket-name/wdpa_staging_csv/*.csv"
```

## Step 4: Write to Final Table

Once the data resides in the staging table with geometry as a WKT `STRING`, use the following SQL query to create the final table. This step converts the WKT string to a `GEOGRAPHY` type using `ST_GEOGFROMTEXT`.

It uses `make_valid => TRUE`, which directs BigQuery to automatically fix common spherical geometry issues like self-intersections or incorrect winding order, which would otherwise cause conversion to fail.

For optimal query performance on geospatial data, **the final table must be clustered by the geography column**, as shown in the query below.

```sql
CREATE OR REPLACE TABLE `your-project.your_dataset_name.final_table`
CLUSTER BY the_geom
AS
SELECT
  * EXCEPT(geometry), -- Select all columns except the original WKT string
  ST_GEOGFROMTEXT(geometry, make_valid => TRUE) AS the_geom -- Convert WKT to GEOGRAPHY, fixing errors
FROM
  `your-project.your_dataset_name.staging_table`
WHERE
  geometry IS NOT NULL AND geometry != '';
```

Your data, including a valid `the_geom` column of type `GEOGRAPHY`, is now ready in `final_table`.

---

## Troubleshooting Common Issues

1.  **WKT String is too long in source file**
    *   If you have geometries with millions of vertices, the WKT string itself can be very large. While BigQuery supports large cells, simplification might be necessary if they exceed limits or if processing is too slow.
    *   **Fix:** Use the Python `shapely` library to simplify the geometry *before* creating the CSV file or uploading. This reduces vertex count while preserving the general shape.
    ```python
    from shapely.wkt import loads
    # Assuming 'poly' is a shapely geometry object
    simplified_poly = poly.simplify(tolerance=0.0001) # Adjust tolerance as needed
    wkt_string = simplified_poly.wkt
    ```

2.  **Memory Errors during Shapefile conversion**
    *   If the Shapefile-to-CSV conversion script in Step 1 runs out of RAM, your geometries or rows are too large for system memory.
    *   **Fix:** If a single shapefile is too large to read into memory, it may need to be split before conversion, or you may need to run conversion on a machine with more RAM.

3. **Alternative Upload: Python Chunks for Large Local CSVs**
    * For very large local CSV files that are difficult to upload to Cloud Storage, or for cases where CSV rows contain extremely large WKT strings that cause memory issues with `bq load`, you can use this Python script to upload directly to BigQuery in chunks. This method can also help if you encounter memory errors during upload.
    * If you use this script and still encounter memory errors, try reducing `CHUNK_SIZE` (e.g., to 1000 or 500).

**Script:**

```python
import pandas as pd
from google.cloud import bigquery

# Configuration
PROJECT_ID = 'your-project'
DATASET_ID = 'your_dataset_name'
TABLE_ID = 'staging_table'
FILE_PATH = 'large_geodata.csv'
CHUNK_SIZE = 10000  # Adjust based on memory

client = bigquery.Client(project=PROJECT_ID)
table_ref = f"{PROJECT_ID}.{DATASET_ID}.{TABLE_ID}"

# Job configuration to ensure WKT is treated as a STRING
job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    autodetect=True,
    allow_quoted_newlines=True,
)

# Process in chunks
reader = pd.read_csv(FILE_PATH, chunksize=CHUNK_SIZE, engine='python') # engine='python' may be slower but more flexible

for i, chunk in enumerate(reader):
    print(f"Uploading chunk {i+1}...")

    # Ensure geometry column is string type before upload
    if 'geometry' in chunk.columns:
        chunk['geometry'] = chunk['geometry'].astype(str)

    # If it's the first chunk, truncate the table. Otherwise, append.
    job_config.write_disposition = "WRITE_TRUNCATE" if i == 0 else "WRITE_APPEND"

    load_job = client.load_table_from_dataframe(
        chunk, table_ref, job_config=job_config
    )
    load_job.result() # Wait for job to finish

print("Staging upload complete.")
```
