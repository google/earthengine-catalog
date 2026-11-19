local id = 'projects/mapbiomas-public/assets/antarctica/lulc/v1';

local subdir = 'mapbiomas-public';

local version = '1.0';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,

  title: 'MapBiomas Land Use and Land Cover - Antarctica V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Antarctica maps the
    land cover of the Antarctic continent and the surrounding islands south of
    60 degrees South at a 10-meter resolution. Collection 1 provides a single map
    for 2025.

    Most of Antarctica is covered by ice and snow, and the ice-free areas, where
    the continent's terrestrial ecosystems are concentrated, take up only a small
    fraction of its surface. The classification legend is compact and centered on
    that contrast, separating ocean, ice and snow, ice-free area and vegetation.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year.

    For more information, classification legend, methodology, and accuracy
    assessments, visit the [MapBiomas website](https://mapbiomas.org/en).
  |||,

  'gee:categories': ['landuse-landcover'],

  keywords: [
    'antarctica',
    'ice',
    'landcover',
    'snow',
  ],

  providers: [
    ee.producer_provider('MapBiomas', 'https://mapbiomas.org'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(
    -180.0,
    -90.0,
    180.0,
    -60.0,
    '2025-01-01T00:00:00Z',
    '2025-12-31T00:00:00Z'
  ),

  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: |||
          Year of the land use and land cover classification.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'version',
        description: |||
          Version of the land use and land cover classification.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'collection_id',
        description: |||
          Collection identifier of the land use and land cover classification.
        |||,
        type: ee_const.var_type.double,
      },
    ],

    gsd: [10],

    'eo:bands': [
      {
        name: 'classification',
        description: |||
          Land use and land cover classification, with integer values
          corresponding to MapBiomas Antarctica legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '2c7bb6', description: 'Ocean'},
          {value: 2,  color: 'e5f2ff', description: 'Ice and snow'},
          {value: 3,  color: '542609', description: 'Ice-free area'},
          {value: 4,  color: '003200', description: 'Vegetation'},
          {value: 10, color: 'cccccc', description: 'No data'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Antarctica',
        lookat: {lon: -58.9, lat: -62.2, zoom: 9},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [10],
            palette: [
              '000000',  // [0] --
              '2c7bb6',  // [1] Ocean
              'e5f2ff',  // [2] Ice and snow
              '542609',  // [3] Ice-free area
              '003200',  // [4] Vegetation
              '000000',  // [5] --
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '000000',  // [9] --
              'cccccc',  // [10] No data
            ],
          },
        },
      },
    ],
  },

  'sci:doi': '10.3390/rs12172735',
  'sci:citation': |||
    Souza et al. (2020) - Reconstructing Three Decades of Land Use and Land Cover
    Changes in Brazilian Biomes with Landsat Archive and Earth Engine - Remote Sensing,
    Volume 12, Issue 17, 10.3390/rs12172735.

    [doi:10.3390/rs12172735](https://doi.org/10.3390/rs12172735)
  |||,

  'gee:terms_of_use': ee.gee_terms_of_use(license),

  'gee:status': 'beta',

  'gee:type': ee_const.gee_type.image_collection,

  license: license.id,

  links: ee.standardLinks(subdir, id),

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
