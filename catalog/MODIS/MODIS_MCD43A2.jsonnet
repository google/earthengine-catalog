local id = 'MODIS/MCD43A2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD43A2_versions.libsonnet';

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
  title: 'MCD43A2.005 BRDF-Albedo Quality 16-Day Global 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODerate-resolution Imaging
    Spectroradiometer (MODIS) BRDF/Albedo Quality product (MCD43A2)
    describes the overall condition of the other BRDF and Albedo
    products. The MCD43A2 product contains 16 days of data at 500 meter
    spatial resolution provided in a level-3 gridded data set in
    Sinusoidal projection, and includes albedo quality, snow conditions,
    ancillary information, and inversion information.  Both Terra and Aqua
    data are used in the generation of this product, providing the highest
    probability for quality input data and designating it as an MCD,
    meaning Combined, product.

    Version-5 MODIS/Terra+Aqua BRDF/Albedo
    products are Validated Stage 1, meaning that accuracy has been
    estimated using a small number of independent measurements obtained
    from selected locations and time periods and ground-truth/field
    program efforts. Although there may be later improved versions, these
    data are ready for use in scientific publications.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['satellite-imagery'],
  keywords: [
    '16_day',
    'albedo',
    'brdf',
    'global',
    'modis',
    'quality',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mcd43a2'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', '2017-03-14T00:00:00Z'),
  summaries: {
    gsd: [
      500.0,
    ],
    instruments: [
      'MODIS',
    ],
    platform: [
      'Aqua',
      'Terra',
    ],
    'eo:bands': [
      {
        name: 'BRDF_Albedo_Quality',
        description: 'BRDF/Albedo mandatory quality',
      },
      {
        name: 'Snow_BRDF_Albedo',
        description: 'Snow-free or snow BRDF/albedo retrieved',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory QA',
              bit_count: 1,
              values: [
                {
                  description: 'Snow-free albedo retrieved',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Snow albedo retrieved',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'BRDF_Albedo_Ancillary',
        description: 'BRDF albedo ancillary quality',
      },
      {
        name: 'BRDF_Albedo_Band_Quality',
        description: 'BRDF albedo band quality',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'BRDF Albedo Quality',
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
            bands: [
              'Snow_BRDF_Albedo',
              'Snow_BRDF_Albedo',
              'BRDF_Albedo_Quality',
            ],
          },
        },
      },
    ],
    BRDF_Albedo_Quality: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    Snow_BRDF_Albedo: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    BRDF_Albedo_Ancillary: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    BRDF_Albedo_Band_Quality: {
      minimum: 0.0,
      maximum: 4294967295.0,
      'gee:estimated_range': false,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: ee_const.version_unknown,
}
