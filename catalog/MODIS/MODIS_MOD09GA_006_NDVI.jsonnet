local id = 'MODIS/MOD09GA_006_NDVI';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD09GA_NDVI_versions.libsonnet';

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
  title: 'MODIS Terra Daily NDVI',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Normalized Difference Vegetation Index is
    generated from the Near-IR and Red bands of each scene as (NIR - Red) /
    (NIR + Red), and ranges in value from -1.0 to 1.0. This product is generated from the MODIS/006/MOD09GA surface reflectance composites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'modis',
    'ndvi',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'NDVI',
        description: 'Normalized Difference Vegetation Index',
        gsd: 463.312716528,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Colorized',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
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
    NDVI: {
      minimum: -1.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  'gee:is_derived': true,
}
