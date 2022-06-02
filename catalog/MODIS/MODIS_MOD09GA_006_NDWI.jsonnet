local id = 'MODIS/MOD09GA_006_NDWI';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'MODIS Terra Daily NDWI',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Normalized Difference Water Index (NDWI) is sensitive
    to changes in liquid water content of vegetation canopies.  It is
    derived from the Near-IR band and a second IR band, &approx;1.24&mu;m when
    available and the nearest available IR band otherwise.  It ranges in
    value from -1.0 to 1.0.  See
    [Gao (1996)](https://www.sciencedirect.com/science/article/pii/S0034425796000673)
    for details. This product is generated from the MODIS/006/MOD09GA surface reflectance composites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'modis',
    'ndwi',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'NDWI',
        description: 'Normalized Difference Water Index',
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
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
              'ffffff',
            ],
            bands: [
              'NDWI',
            ],
          },
        },
      },
    ],
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
