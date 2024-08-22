local id = 'MODIS/MOD13A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD13A1_versions.libsonnet';

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
  title: 'MOD13A1.005 Vegetation Indices 16-Day L3 Global 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Global MODIS vegetation indices are designed to
    provide consistent spatial and temporal comparisons of vegetation conditions.
    Blue, red, and near-infrared reflectances, centered at 469-nanometers,
    645-nanometers, and 858-nanometers, respectively, are used to determine the
    MODIS daily vegetation indices.

    The MODIS Normalized Difference Vegetation Index (NDVI) complements
    NOAA's Advanced Very High Resolution Radiometer (AVHRR) NDVI products
    provide continuity for time series historical applications. MODIS also
    includes a new Enhanced Vegetation Index (EVI) that minimizes canopy
    background variations and maintains sensitivity over dense vegetation
    conditions. The EVI also uses the blue band to remove residual atmosphere
    contamination caused by smoke and sub-pixel thin cloud clouds. The MODIS
    NDVI and EVI products are computed from atmospherically corrected
    bi-directional surface reflectances that have been masked for water, clouds,
    heavy aerosols, and cloud shadows.

    Global MOD13A1 data are provided every 16 days at 500-meter spatial
    resolution as a gridded level-3 product in the Sinusoidal projection.
    Vegetation indices are used for global monitoring of vegetation conditions
    and are used in products displaying land cover and land cover changes. These
    data may be used as input for modeling global biogeochemical and hydrologic
    processes and global and regional climate. These data also may be used for
    characterizing land surface biophysical properties and processes, including
    primary production and land cover conversion.

    Version-5 MODIS Vegetation Indices products have attained Validation Stage
    3.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    '16_day',
    'evi',
    'global',
    'mod13a1',
    'modis',
    'ndvi',
    'terra',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod13a1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', null),
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
