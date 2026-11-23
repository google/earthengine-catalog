local id = 'projects/mapbiomas-public/assets/paraguay/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Paraguay V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Paraguay is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    The Paraguay River splits the country into two contrasting halves: the dry
    woodlands and wetlands of the Chaco to the west, and the Eastern Region, where
    the remnants of the Atlantic Forest sit alongside the country's main
    agricultural frontier. The classification legend separates closed, open and
    flooded natural woodlands from flooded grasslands, pasture and agriculture.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://paraguay.mapbiomas.org/en).
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
    -62.6438,
    -27.5918,
    -54.2571,
    -19.2876,
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
          corresponding to MapBiomas Paraguay legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Woody Natural Vegetation'},
          {value: 3,  color: '1f8d49', description: 'Closed Natural Woodlands'},
          {value: 4,  color: '7dc975', description: 'Open Natural Woodlands'},
          {value: 6,  color: '007785', description: 'Flooded Natural Woodlands'},
          {value: 9,  color: '7a6c00', description: 'Forest Plantation'},
          {value: 10, color: 'd6bc74', description: 'Herbaceous Natural Vegetation'},
          {value: 11, color: '519799', description: 'Flooded grasslands'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 14, color: 'ffefc3', description: 'Agricultural Areas'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 25, color: 'db4d4f', description: 'Other non-vegetated area'},
          {value: 26, color: '2532e4', description: 'Water body'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 33, color: '2532e4', description: 'River, lake or ocean'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Paraguay',
        lookat: {lon: -58.4, lat: -23.4, zoom: 6},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [33],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Woody Natural Vegetation
              '000000',  // [2] --
              '1f8d49',  // [3] Closed Natural Woodlands
              '7dc975',  // [4] Open Natural Woodlands
              '000000',  // [5] --
              '007785',  // [6] Flooded Natural Woodlands
              '000000',  // [7] --
              '000000',  // [8] --
              '7a6c00',  // [9] Forest Plantation
              'd6bc74',  // [10] Herbaceous Natural Vegetation
              '519799',  // [11] Flooded grasslands
              'd6bc74',  // [12] Grassland
              '000000',  // [13] --
              'ffefc3',  // [14] Agricultural Areas
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              '000000',  // [21] --
              'd4271e',  // [22] Non-vegetated area
              '000000',  // [23] --
              '000000',  // [24] --
              'db4d4f',  // [25] Other non-vegetated area
              '2532e4',  // [26] Water body
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              '000000',  // [29] --
              '000000',  // [30] --
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, lake or ocean
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
