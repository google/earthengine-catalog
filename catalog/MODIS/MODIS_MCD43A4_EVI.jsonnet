local id = 'MODIS/MCD43A4_EVI';
local successor_id = 'MODIS/MCD43A4_006_EVI';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MODIS Combined 16-Day EVI [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Enhanced Vegetation Index (EVI) is generated from the
    Near-IR, Red and Blue bands of each scene, and ranges in value from
    -1.0 to 1.0. See
    [Huete et al. (2002)](https://www.sciencedirect.com/science/article/pii/S0034425702000962)
    for details. This product is generated from the MODIS/MCD43A4 surface reflectance composites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'evi',
    'modis',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', '2017-03-14T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'EVI',
        description: 'Enhanced Vegetation Index',
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
        filter: {
          filter_name: 'DATE_RANGE',
          time_start: '2018-04-01',
          time_end: '2018-06-01',
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
              'FFFFFF',
              'CE7E45',
              'DF923D',
              'F1B555',
              'FCD163',
              '99B718',
              '74A901',
              '66A000',
              '529400',
              '3E8601',
              '207401',
              '056201',
              '004C00',
              '023B01',
              '012E01',
              '011D01',
              '011301',
            ],
            bands: [
              'EVI',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  'gee:is_derived': true,
  version: 'Unknown',
}
