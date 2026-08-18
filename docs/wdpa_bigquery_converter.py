import os
import tempfile
import zipfile
import pandas as pd
import geopandas as gpd

# --- CONFIGURATION ---
# The path to your main downloaded ZIP file containing shapefile ZIPs
MAIN_ZIP_PATH = "/path/to/your/WDPA_WDOECM_Jan2026_Public_all_shp.zip"
# Where you want the final CSV files to be saved
OUTPUT_DIR = "./wdpa_csv_output"
# The base name of the shapefiles within the inner zips, used to find
# point/polygon layers
# e.g., if shapefiles are "MY_DATA-points.shp", base name is "MY_DATA"
SHP_BASE_NAME = "WDPA_WDOECM_Jan2026_Public_all_shp"


def convert_shp_to_csv(
    main_zip_path: str, output_dir: str, shp_base_name: str
) -> None:
  """Extracts shapefiles from a nested zip structure (like WDPA),

  reprojects them to EPSG:4326, converts geometry to WKT,
  and saves them as CSV files.

  Args:
      main_zip_path: The path to the main downloaded ZIP file.
      output_dir: The directory where the final CSV files will be saved.
      shp_base_name: The base name of the shapefiles within the inner zips.
  """
  try:
    os.makedirs(output_dir)
  except FileExistsError:
    # Directory already exists, which is fine.
    pass
  except OSError as e:
    print(f"Error creating output directory {output_dir}: {e}")
    return

  def process_gdf(gdf: gpd.GeoDataFrame, layer: str, i: int) -> bool:
    """Reprojects, fixes columns, converts geometry to WKT and saves to CSV."""
    if gdf.empty:
      print(f"Data for layer '{layer}' part {i} is empty. Skipping.")
      return False

    # 1. Force CRS to WGS84 (BigQuery Requirement for GEOGRAPHY)
    if gdf.crs != "EPSG:4326":
      print(f"Reprojecting {layer} from {gdf.crs} to EPSG:4326...")
      gdf = gdf.to_crs(epsg=4326)

    # 2. Fix potential column name issues
    # BigQuery columns must be alphanumeric/underscores.
    gdf.columns = [
        c.replace(" ", "_").replace("-", "_").replace(".", "_")
        for c in gdf.columns
    ]

    # 3. Convert geometry to WKT string
    print("Converting geometry to WKT...")
    geom_col = gdf.geometry.name

    df = pd.DataFrame(gdf.copy())

    df["geometry"] = gdf[geom_col].apply(
        lambda x: x.wkt if x is not None and not x.is_empty else None
    )

    if geom_col != "geometry" and geom_col in df.columns:
       df = df.drop(columns=[geom_col])

    # 4. Export to CSV
    out_filename = f"wdpa_{layer}_part_{i}.csv"
    out_path = os.path.join(output_dir, out_filename)

    print(f"Writing {out_filename}...")
    df.to_csv(out_path, index=False, chunksize=50000)
    print(f"Finished writing {out_filename}")
    return True

  # Create a temporary directory to work in
  with tempfile.TemporaryDirectory() as temp_dir:
    print(f"--- Extracting main ZIP to temporary location ---")
    try:
      with zipfile.ZipFile(main_zip_path, "r") as zip_ref:
        zip_ref.extractall(temp_dir)
    except FileNotFoundError:
      print(f"Error: Main ZIP file not found at {main_zip_path}")
      return
    except zipfile.BadZipFile:
      print(f"Error: File at {main_zip_path} is not a valid ZIP file.")
      return

    # Find sub-zips inside the extracted directory
    sub_zips = [f for f in os.listdir(temp_dir) if f.endswith(".zip")]
    sub_zips.sort()  # Ensure order if numbered, e.g., 0.zip, 1.zip, 2.zip

    layers = ["polygons", "points"]

    if not sub_zips:
      print(
          f"No sub-ZIP files found in {main_zip_path}. Looking for .shp files"
          " directly in extracted folder."
      )
      processed_something = False
      for layer in layers:
        shp_name = f"{shp_base_name}-{layer}.shp"
        shp_path = os.path.join(temp_dir, shp_name)
        print(f"--- Attempting to process {shp_path} ---")
        try:
          gdf = gpd.read_file(shp_path)
          if process_gdf(gdf, layer, 0):
            processed_something = True
        except FileNotFoundError:
          print(f"Shapefile '{shp_name}' not found at {shp_path}.")
        except Exception as e:
          print(f"Error processing shapefile '{shp_path}': {e}")

      if not processed_something:
        print("No shapefiles processed from ZIP root.")
        return
    else:
      print(f"Found {len(sub_zips)} sub-zips: {sub_zips}")

      for i, sz in enumerate(sub_zips):
        full_sz_path = os.path.join(temp_dir, sz)

        for layer in layers:
          print(f"--- Processing {layer} from {sz} ---")
          shp_name = f"{shp_base_name}-{layer}.shp"
          try:
            # Construct the path to the shapefile inside the sub-zip
            uri = f"zip://{full_sz_path}!{shp_name}"
            # Read the shapefile using GeoPandas
            gdf = gpd.read_file(uri)
            process_gdf(gdf, layer, i)
          except Exception as e:
            print(f"Error processing layer '{layer}' in '{sz}': {e}")
            print(f"Please ensure '{shp_name}' exists within '{sz}'.")

  print(
      f"\nSuccess! All CSV files are located in: {os.path.abspath(output_dir)}"
  )
  print("Files created:")
  for f in sorted(os.listdir(output_dir)):
    print(f" - {f}")


if __name__ == "__main__":
  convert_shp_to_csv(MAIN_ZIP_PATH, OUTPUT_DIR, SHP_BASE_NAME)
