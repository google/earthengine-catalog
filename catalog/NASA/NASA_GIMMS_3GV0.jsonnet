local id = 'NASA/GIMMS/3GV0';
local subdir = 'NASA';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GIMMS NDVI From AVHRR Sensors (3rd Generation)',
  version: '3g.v0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    GIMMS NDVI is generated from several NOAA's AVHRR sensors for a global
    1/12-degree lat/lon grid. The latest version of the GIMMS NDVI dataset
    is named NDVI3g (third generation GIMMS NDVI from AVHRR sensors).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    // TODO(b/229788964): Source site is gone and the authors are not responding.
    // {
    //   rel: ee_const.rel.source,
    //   href: 'https://ecocast.arc.nasa.gov/data/pub/gimms/3g.v0/',
    // },
  ],
  keywords: [
    'avhrr',
    'gimms',
    'nasa',
    'ndvi',
    'noaa',
    'vegetation',
  ],
  providers: [
    // TODO(b/229788964): Fix the broken link.
    ee.producer_provider('NASA/NOAA', 'https://nex.nasa.gov/nex/projects/1349/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1981-07-01T00:00:00Z', '2013-12-16T00:00:00Z'),
  summaries: {
    gsd: [
      9277.0,
    ],
    'eo:bands': [
      {
        name: 'ndvi',
        description: 'NDVI',
      },
      {
        name: 'qa',
        description: 'QA flag',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'QA flag values',
              bit_count: 3,
              values: [
                {
                  value: 1,
                  description: 'Good value',
                },
                {
                  value: 2,
                  description: 'Good value',
                },
                {
                  value: 3,
                  description: 'NDVI retrieved from spline interpolation',
                },
                {
                  value: 4,
                  description: 'NDVI retrieved from spline interpolation, possibly snow',
                },
                {
                  value: 5,
                  description: 'NDVI retrieved from average seasonal profile',
                },
                {
                  value: 6,
                  description: 'NDVI retrieved from average seasonal profile, possibly snow',
                },
                {
                  value: 7,
                  description: 'Missing data',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NDVI',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '000000',
              'f5f5f5',
              '119701',
            ],
            bands: [
              'ndvi',
            ],
          },
        },
      },
    ],
    ndvi: {
      minimum: -1.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 15,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
