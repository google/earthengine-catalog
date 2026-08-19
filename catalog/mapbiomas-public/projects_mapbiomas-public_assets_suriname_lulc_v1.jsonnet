local id = 'projects/mapbiomas-public/assets/suriname/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Suriname V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Suriname is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    Suriname is covered in large part by dense tropical rainforest, with a narrow
    coastal plain that concentrates the mangroves, the agricultural land and most
    of the population. This is reflected in a compact classification legend, which
    includes mangrove, wetland, grassland, mining and urban area alongside the
    forest classes.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://suriname.mapbiomas.org/en).
  |||,

  'gee:categories': ['landuse-landcover'],

  keywords: [
    'landsat_derived',
  ],

  providers: [
    ee.producer_provider('MapBiomas', 'https://mapbiomas.org'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent(
    -58.4309,
    1.4599,
    -53.9494,
    6.1961,
    '1985-01-01T00:00:00Z',
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

    gsd: [30],

    'eo:bands': [
      {
        name: 'classification',
        description: |||
          Land use and land cover classification, with integer values
          corresponding to MapBiomas Suriname legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Forest'},
          {value: 3,  color: '1f8d49', description: 'Forest Formation'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 10, color: 'd6bc74', description: 'Herbaceous and Shrubby Vegetation'},
          {value: 11, color: '519799', description: 'Wetland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Farming'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of Uses'},
          {value: 22, color: 'd4271e', description: 'Non vegetated Area'},
          {value: 24, color: 'd4271e', description: 'Urban Area'},
          {value: 25, color: 'db4d4f', description: 'Other non Vegetated Area'},
          {value: 26, color: '2532e4', description: 'Water'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 30, color: '9c0027', description: 'Mining'},
          {value: 33, color: '2532e4', description: 'River, lake and Ocean'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Suriname',
        lookat: {lon: -55.9, lat: 4.2, zoom: 7},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [33],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest Formation
              '000000',  // [4] --
              '04381d',  // [5] Mangrove
              '000000',  // [6] --
              '000000',  // [7] --
              '000000',  // [8] --
              '000000',  // [9] --
              'd6bc74',  // [10] Herbaceous and Shrubby Vegetation
              '519799',  // [11] Wetland
              'd6bc74',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Farming
              '000000',  // [15] --
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of Uses
              'd4271e',  // [22] Non vegetated Area
              '000000',  // [23] --
              'd4271e',  // [24] Urban Area
              'db4d4f',  // [25] Other non Vegetated Area
              '2532e4',  // [26] Water
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              '000000',  // [29] --
              '9c0027',  // [30] Mining
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, lake and Ocean
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
