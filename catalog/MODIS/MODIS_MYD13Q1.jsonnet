local id = 'MODIS/MYD13Q1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD13Q1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD13Q1.005 Vegetation Indices 16-Day Global 250m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Normalized Difference Vegetation Index
    (NDVI) complements NOAA's Advanced Very High Resolution Radiometer (AVHRR) NDVI
    products and provides continuity for time series historical applications. MODIS
    also includes a new Enhanced Vegetation Index (EVI) that minimizes canopy
    background variations and maintains sensitivity over dense vegetation
    conditions. The EVI also uses the blue band to remove residual atmosphere
    contamination caused by smoke and sub-pixel thin cloud clouds. The MODIS NDVI
    and EVI products are computed from atmospherically corrected bi-directional
    surface reflectances that have been masked for water, clouds, heavy aerosols,
    and cloud shadows.

    MOD13AQ1 is comprised of the following layers:

    - NDVI: Normalized Difference Vegetation Index, Scale 0.0001
    - EVI: Enhanced Vegetation Index, Scale 0.0001
    - DetailedQA: VI Quality, see MOD13Q1 VI Quality
    - sur_refl_b01: Red surface reflectance, scale 0.0001
    - sur_refl_b02: NIR surface reflectance, scale 0.0001
    - sur_refl_b03: Blue surface reflectance, scale 0.0001
    - sur_refl_b07: MIR surface reflectance, scale 0.0001
    - ViewZenith: View zenith angle, scale 0.01
    - SolarZenith: Solar zenith angle, scale 0.01
    - RelativeAzimuth: Relative azimuth angle, scale 0.1
    - DayOfYear: Julian day of year
    - SummaryQA: Pixel reliability summary QA
       - -1 Fill/No data: Not processed
       - 0 Good data: Use with confidence
       - 1 Marginal data: Useful but look at detailed QA for more information
       - 2 Snow/ice: Pixel covered with snow/ice
       - 3: Cloudy: Pixel is cloudy

    MOD13Q1 IV Quality

    - Bits 0-1: MODLAND_QA
       - 00 (0): VI produced, good quality
       - 01 (1): VI produced, check other QA
       - 10 (2): Pixel produced, probably cloudy
       - 11 (3): Pixel not produced due to other reason (not clouds)
    - Bits 2-5: VI Usefulness
       - 0000 (0): Highest quality
       - 0001 (1): Lower quality
       - 0010 (2): Decreasing quality
       - 0100 (4): Decreasing quality
       - 1000 (8): Decreasing quality
       - 1001 (9): Decreasing quality
       - 1010 (10): Decreasing quality
       - 1100 (12): Lowest quality
       - 1101 (13): Quality so low that it is not useful
       - 1110 (14): L1B data faulty
       - 1111 (15): Not useful for any other reason/not processed
    - Bits 6-7: Aerosol quantity
       - 00 (0): Climatology
       - 01 (1): Low
       - 10 (2): Average
       - 11 (3): High
    - Bit 8: Adjacent cloud detected
       - 0: No
       - 1: Yes
    - Bit 9: Atmosphere BRDF correction performed
       - 0: No
       - 1: Yes
    - Bit 10: Mixed Clouds
        - 0: No
        - 1: Yes
    - Bits 11-13: Land/Water flag
       - 000 (0): Shallow ocean
       - 001 (1): Land
       - 010 (2): Ocean coastlines and lake shorelines
       - 011 (3): Shallow inland water
       - 100 (4): Ephemeral water
       - 101 (5): Deep inland water
       - 110 (6): Moderate or continental ocean
       - 111 (7): Deep ocean
    - Bit 14: Possible snow/ice
       - 0: No
       - 1: Yes
    - Bit 15: Possible shadow
       - 0: No
       - 1: Yes

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    '16_day',
    'aqua',
    'evi',
    'global',
    'modis',
    'myd13q1',
    'ndvi',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/myd13q1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'NDVI',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            gain: [
              0.0001,
            ],
            bias: [
              0.0,
            ],
            palette: [
              'ffffff',
              'ce7e45',
              'df923d',
              'f1b555',
              'fcd163',
              '99b718',
              '74a901',
              '66a000',
              '529400',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '023b01',
              '012e01',
              '011d01',
              '011301',
            ],
            bands: [
              'NDVI',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: ee_const.version_unknown,
}
