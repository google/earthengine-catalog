This dataset folder contains the Custom Satellite Embeddings sample suite, a
curated set of analysis-ready sub-annual geospatial embeddings produced by
AlphaEarth Foundations for specific regions and use cases. While the
[global annual Satellite Embedding dataset](https://developers.google.com/earth-engine/datasets/catalog/GOOGLE_SATELLITE_EMBEDDING_V1_ANNUAL#description)
summarizes surface conditions over a full calendar year, Custom Satellite
Embeddings are generated for custom sub-annual time windows such as monthly,
seasonal, non-calendar-year-annual, or event-specific intervals.
[Read more](https://mapsplatform.google.com/resources/blog/introducing-custom-satellite-embeddings-powered-by-alphaearth-foundations/)
about Custom Satellite Embeddings and express interest
[here](https://mapsplatform.google.com/lp/geospatial-analytics-signup/).

Each sample dataset in this folder is published as its own Earth Engine
`ImageCollection` with a consistent geographic footprint and temporal cadence,
and can be loaded directly using its `ImageCollection` ID in the table below.
Note that time intervals in the table use an inclusive start time and an
exclusive end time. The underlying Cloud-Optimized GeoTIFFs and manifest files
are also available in Google Cloud Storage at
`gs://alphaearth_foundations_custom/custom_satellite_embedding/v1/`. Read more
in the [README](https://developers.google.com/earth-engine/guides/custom_embedding_samples_on_gcs_readme).

| Sample Dataset | Earth Engine ImageCollection ID | Description and Temporal Coverage |
| :--- | :--- | :--- |
| Corcoran City Agricultural Change | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/CORCORAN_CITY_2026_AGRICULTURAL_CHANGE` | Winter bare soil (Dec 15, 2025 &ndash; Feb 15, 2026) and spring peak greenness (Mar 15 &ndash; May 15, 2026) embeddings capturing agricultural crop dynamics over two seasonal windows across Corcoran and the surrounding agricultural region in California, USA. |
| Futaleuf&uacute; Argentina Fire Scar | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/FUTALEUFU_ARGENTINA_2026_FIRE_SCAR` | Pre-fire (Dec 1&ndash;31, 2025) and post-fire (Mar 1&ndash;31, 2026) embeddings capturing wildfire burn scar extent and forest canopy disturbance from the 2026 Los Alerces Wildfire across Los Alerces National Park and the surrounding region in Futaleuf&uacute; Department, Chubut Province, Argentina. |
| King County Monthly | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/KING_COUNTY_2025_MONTHLY` | Calendar-month embeddings for the King County administrative area in Washington, USA, for the first six months of 2025, covering diverse urban city infrastructure and forested land. |
| Meloland California Crop Cycles | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/MELOLAND_CALIFORNIA_2026_CROP_CYCLES` | Six sequential monthly (15th to 15th) embedding time steps (mid-November 2025 through mid-May 2026) tracking multi-crop rotation cycles across Meloland and surrounding agricultural fields in the Imperial Valley, California, USA. |
| Pacific Palisades Fire Scar | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/PACIFIC_PALISADES_2025_FIRE` | Pre-fire (Dec 7, 2024 &ndash; Jan 7, 2025) and post-fire (Jan 7 &ndash; Feb 7, 2025) 31-day embeddings capturing Palisades Fire wildfire impact and land cover change across Pacific Palisades and surrounding coastal hills in Los Angeles, California, USA. |
| Theewaterskloof Dam Water Change | `GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/THEEWATERSKLOOF_DAM_2026_WATER_CHANGE` | Dry-season (Jan 1&ndash;31, 2026) and wet-season recharge (Apr 15 &ndash; May 15, 2026) embeddings capturing reservoir water surface area changes at Theewaterskloof Dam in Theewaterskloof Local Municipality, South Africa. |
