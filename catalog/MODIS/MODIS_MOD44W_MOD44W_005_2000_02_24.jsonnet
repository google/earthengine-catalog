local id = 'MODIS/MOD44W/MOD44W_005_2000_02_24';
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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD44W.005 Land Water Mask Derived From MODIS and SRTM',
  version: '5',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Global Water Mask uses the SWBD (SRTM Water Body
    Data) in combination with MODIS 250m data to create a complete
    global map of surface water at 250m spatial resolution, circa 2000-2002.  This
    dataset is intended for use in processing of raster data and for
    masking out water in final raster data products.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'geophysical',
    'mod44w',
    'modis',
    'srtm',
    'water_mask',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', '2000-02-24T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    platform: [
      'Space Shuttle Endeavour',
      'Terra',
    ],
    instruments: [
      'MODIS',
      'SRTM',
    ],
    'eo:bands': [
      {
        name: 'water_mask',
        description: 'Land-water mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land-water mask',
              bit_count: 1,
              values: [
                {
                  description: 'Land',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Water',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'water_mask_qa',
        description: 'Shows which data source provided the water pixel.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Land-water mask HDF science QA',
              bit_count: 4,
              values: [
                {
                  value: 1,
                  description: 'SRTM water body dataset (SWBD) water',
                },
                {
                  value: 2,
                  description: 'MODIS 250m water-hits water',
                },
                {
                  value: 3,
                  description: 'MODIS 250m decision-tree water',
                },
                {
                  value: 4,
                  description: 'Digitized water',
                },
                {
                  value: 5,
                  description: 'Mosaic of Antarctica (MOA) water',
                },
                {
                  value: 10,
                  description: 'Digitized land',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 4,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Mask',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              350.0,
            ],
            gamma: [
              2.5,
            ],
            bands: [
              'water_mask',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
