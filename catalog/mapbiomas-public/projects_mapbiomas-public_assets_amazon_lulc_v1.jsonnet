local id = 'projects/mapbiomas-public/assets/amazon/lulc/v1';

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

  title: 'MapBiomas Land Use and Land Cover - Amazon V' + version,

  version: version,

  description: |||
    MapBiomas Land Use and Land Cover (LULC) dataset for Amazon is produced
    annually by the MapBiomas Project using Landsat satellite imagery and machine
    learning classification techniques. The dataset provides consistent annual land
    cover maps at a 30-meter resolution.

    This dataset covers the Pan-Amazon as delimited by RAISG, a transboundary
    territory shared by Brazil, Bolivia, Colombia, Ecuador, French Guiana, Guyana,
    Peru, Suriname and Venezuela. The legend spans the range of that territory,
    from forest formation, flooded forest and mangrove to the Andean glaciers on
    its western edge, and includes oil palm, mining and the mosaic of uses that
    marks the agricultural frontier.

    Each image in the collection contains one band named "classification", with
    integer values representing categorical land cover classes for that year. The
    classification is based on Landsat 5 (TM), Landsat 7 (ETM+), Landsat 8 and 9
    (OLI/TIRS) surface reflectance data, preprocessed to generate annual cloud-free
    composites. The classification process uses the Random Forest algorithm trained
    with reference samples collected and validated by regional experts.

    For more information, classification legend, methodology, and accuracy assessments,
    visit the [MapBiomas website](https://amazonia.mapbiomas.org/en).
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
    -79.6172,
    -20.5351,
    -43.3993,
    10.0592,
    '1985-01-01T00:00:00Z',
    '2023-12-31T00:00:00Z'
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
          corresponding to MapBiomas Amazon legend classes.
        |||,
        'gee:classes': [
          {value: 1,  color: '1f8d49', description: 'Natural forest'},
          {value: 3,  color: '1f8d49', description: 'Forest formation'},
          {value: 4,  color: '7dc975', description: 'Savanna formation / Open forest'},
          {value: 5,  color: '04381d', description: 'Mangrove'},
          {value: 6,  color: '026975', description: 'Flooded forest'},
          {value: 9,  color: '7a5900', description: 'Silviculture'},
          {value: 10, color: 'd6bc74', description: 'Non-forest natural formation'},
          {value: 11, color: '519799', description: 'Flooded grassland / Shrubland'},
          {value: 12, color: 'd6bc74', description: 'Grassland'},
          {value: 13, color: 'd89f5c', description: 'Other non-forest natural formation'},
          {value: 14, color: 'ffefc3', description: 'Farming and silviculture'},
          {value: 15, color: 'edde8e', description: 'Pasture'},
          {value: 18, color: 'e974ed', description: 'Agriculture'},
          {value: 21, color: 'ffefc3', description: 'Mosaic of uses'},
          {value: 22, color: 'd4271e', description: 'Non-vegetated area'},
          {value: 23, color: 'ffa07a', description: 'Beach, dune and sand spot'},
          {value: 24, color: 'd4271e', description: 'Urban infrastructure'},
          {value: 25, color: 'db4d4f', description: 'Other anthropic non-vegetated area'},
          {value: 26, color: '2532e4', description: 'Water'},
          {value: 27, color: 'ffffff', description: 'Not observed'},
          {value: 29, color: 'ffaa5f', description: 'Rock outcrop'},
          {value: 30, color: '9c0027', description: 'Mining'},
          {value: 33, color: '2532e4', description: 'River, lake and ocean'},
          {value: 34, color: '93dfe6', description: 'Glacier'},
          {value: 35, color: '9065d0', description: 'Oil palm'},
          {value: 68, color: 'e97a7a', description: 'Other natural non-vegetated area'},
        ],
      },
    ],

    'gee:visualizations': [
      {
        display_name: 'Land Use and Cover - MapBiomas Amazon',
        lookat: {lon: -62.0, lat: -4.0, zoom: 4},
        image_visualization: {
          band_vis: {
            bands: ['classification'],
            min: [0],
            max: [68],
            palette: [
              '000000',  // [0] --
              '1f8d49',  // [1] Natural forest
              '000000',  // [2] --
              '1f8d49',  // [3] Forest formation
              '7dc975',  // [4] Savanna formation / Open forest
              '04381d',  // [5] Mangrove
              '026975',  // [6] Flooded forest
              '000000',  // [7] --
              '000000',  // [8] --
              '7a5900',  // [9] Silviculture
              'd6bc74',  // [10] Non-forest natural formation
              '519799',  // [11] Flooded grassland / Shrubland
              'd6bc74',  // [12] Grassland
              'd89f5c',  // [13] Other non-forest natural formation
              'ffefc3',  // [14] Farming and silviculture
              'edde8e',  // [15] Pasture
              '000000',  // [16] --
              '000000',  // [17] --
              'e974ed',  // [18] Agriculture
              '000000',  // [19] --
              '000000',  // [20] --
              'ffefc3',  // [21] Mosaic of uses
              'd4271e',  // [22] Non-vegetated area
              'ffa07a',  // [23] Beach, dune and sand spot
              'd4271e',  // [24] Urban infrastructure
              'db4d4f',  // [25] Other anthropic non-vegetated area
              '2532e4',  // [26] Water
              'ffffff',  // [27] Not observed
              '000000',  // [28] --
              'ffaa5f',  // [29] Rock outcrop
              '9c0027',  // [30] Mining
              '000000',  // [31] --
              '000000',  // [32] --
              '2532e4',  // [33] River, lake and ocean
              '93dfe6',  // [34] Glacier
              '9065d0',  // [35] Oil palm
              '000000',  // [36] --
              '000000',  // [37] --
              '000000',  // [38] --
              '000000',  // [39] --
              '000000',  // [40] --
              '000000',  // [41] --
              '000000',  // [42] --
              '000000',  // [43] --
              '000000',  // [44] --
              '000000',  // [45] --
              '000000',  // [46] --
              '000000',  // [47] --
              '000000',  // [48] --
              '000000',  // [49] --
              '000000',  // [50] --
              '000000',  // [51] --
              '000000',  // [52] --
              '000000',  // [53] --
              '000000',  // [54] --
              '000000',  // [55] --
              '000000',  // [56] --
              '000000',  // [57] --
              '000000',  // [58] --
              '000000',  // [59] --
              '000000',  // [60] --
              '000000',  // [61] --
              '000000',  // [62] --
              '000000',  // [63] --
              '000000',  // [64] --
              '000000',  // [65] --
              '000000',  // [66] --
              '000000',  // [67] --
              'e97a7a',  // [68] Other natural non-vegetated area
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
