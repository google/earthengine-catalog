local id = 'LANDFIRE/Vegetation/BPS/v1_4_0';
local subdir = 'LANDFIRE';

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
  title: 'LANDFIRE BPS (Biophysical Settings) v1.4.0',
  version: '1.4.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    LANDFIRE (LF), Landscape Fire and Resource Management Planning Tools, is a
    shared program between the wildland fire management programs of the U.S.
    Department of Agriculture's Forest Service, U.S. Department of the Interior's
    Geological Survey, and The Nature Conservancy.

    LANDFIRE (LF) layers are created using predictive landscape models based on
    extensive field-referenced data, satellite imagery and biophysical gradient
    layers using classification and regression trees.

    LANDFIRE's (LF) Biophysical Settings (BPS) represents the vegetation that may have been dominant on the landscape prior to Euro-American settlement and is based on both the current biophysical environment and an approximation of the historical disturbance regime.
    Map units are based on NatureServe's Ecological Systems classification and represent the natural plant communities that may have been present during the reference period. Each BPS map unit is matched with a model of vegetation succession, and both serve as key inputs to the LANDSUM landscape succession model.
    The actual time period for this data set is a composite of both the historical context provided by the fire regime and vegetation dynamics models and the more recent field and geospatial inputs used to create it.
    LF's current BPS is unchanged from LF National's BPS except for updates made to water, barren, and snow classes (additions or removal), so that non-vegetated cover types within the BPS product matches LF existing vegetation and fuel products.
    With the final release of LF Remap for CONUS in mid to late 2020, the LF Remap BPS product will include the following as attributes: Mean Fire Return Interval (MFRI), Percent of Low-severity Fire (PLS), Percent of Mixed-severity Fire (PMS), Percent of Replacement-severity Fire (PRS), and Fire Regime Groups (FRG), so that the linkage of these characteristics to BPS is maintained.
    LF uses BPS to depict reference conditions of vegetation across landscapes.

    The LANDIFRE Vegetation datasets include:

    * Biophysical Settings (BPS)
    * Environmental Site Potential (ESP)
    * Existing Vegetation Canopy Cover (EVC)
    * Existing Vegetation Height (EVH).
    * Existing Vegetation Type (EVT)
    These layers are created using predictive landscape models based on extensive
    field-referenced data, satellite imagery and biophysical gradient layers using
    classification and regression trees.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'doi',
    'fire',
    'landfire',
    'nature_conservancy',
    'usda',
    'usgs',
    'vegetation',
    'wildfire',
  ],
  providers: [
    ee.producer_provider("U.S. Department of Agriculture's (USDA), U.S. Forest Service (USFS), U.S.
Department of the Interior's Geological Survey (USGS), and The Nature Conservancy.", 'https://landfire.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-175.1, 17.52, -63.66, 71.48,
                    '2014-09-01T00:00:00Z', '2014-09-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'BPS_classes',
        description: 'Class values of the Biophysical Settings.',
        type: ee_const.var_type.double,
      },
      {
        name: 'BPS_names',
        description: 'Descriptive names of the Biophysical Settings.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'BPS',
        description: 'Biophysical Settings',
        'gee:classes': [
          {
            value: 11,
            color: '005ce6',
            description: 'Open Water',
          },
          {
            value: 12,
            color: 'ffffff',
            description: 'PerennialIce/Snow',
          },
          {
            value: 31,
            color: '000000',
            description: 'Barren-Rock/Sand/Clay',
          },
          {
            value: 381,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 383,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 384,
            color: 'ffffbe',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 385,
            color: 'ffffbe',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 386,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 387,
            color: '89cd66',
            description: 'Western Great Plains Foothill and Piedmont Grassland',
          },
          {
            value: 388,
            color: '848cc8',
            description: 'Wyoming Basins Dwarf Sagebrush Shrubland and Steppe',
          },
          {
            value: 389,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 390,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 391,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 392,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 393,
            color: 'e54563',
            description: 'Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub',
          },
          {
            value: 394,
            color: '349bcf',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 395,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 396,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 397,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 398,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 399,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe - Mountain Big Sagebrush',
          },
          {
            value: 400,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 401,
            color: '0bbe7f',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 402,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 403,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 404,
            color: '349bcf',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 405,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 406,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 407,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 408,
            color: 'fff5d7',
            description: 'Mediterranean California Sparsely Vegetated Systems',
          },
          {
            value: 409,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 410,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 411,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 412,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 413,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 414,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 415,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 416,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 417,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Ponderosa Pine-Douglas-fir',
          },
          {
            value: 418,
            color: '9624b5',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Larch',
          },
          {
            value: 419,
            color: 'e60508',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Grand Fir',
          },
          {
            value: 420,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 421,
            color: '5f93e5',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 422,
            color: '129054',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest - Cedar Groves',
          },
          {
            value: 423,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 424,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 425,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 426,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 427,
            color: 'beffe8',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 428,
            color: '13765c',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 429,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 430,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 431,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 432,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 433,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 434,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 435,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 436,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 437,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 438,
            color: 'cdf57a',
            description: 'Columbia Basin Foothill and Canyon Dry Grassland',
          },
          {
            value: 439,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 440,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 441,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 442,
            color: 'dcdc00',
            description: 'Columbia Basin Palouse Prairie',
          },
          {
            value: 443,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 444,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 445,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 446,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 447,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 448,
            color: '444f89',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 449,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 450,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 451,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 452,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 453,
            color: '0bcaaa',
            description: 'Northwestern Great Plains Aspen Forest and Parkland',
          },
          {
            value: 454,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 455,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 456,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Ponderosa Pine-Douglas-fir',
          },
          {
            value: 457,
            color: '9624b5',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Larch',
          },
          {
            value: 458,
            color: 'e60508',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Grand Fir',
          },
          {
            value: 459,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 460,
            color: '5f93e5',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 461,
            color: '129054',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest - Cedar Groves',
          },
          {
            value: 462,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 463,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 464,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 465,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 466,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 467,
            color: '13765c',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 468,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 469,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 470,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 471,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 472,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 473,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 474,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 475,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 476,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 477,
            color: '828282',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 478,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 479,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 480,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 481,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 482,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 483,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 484,
            color: '444f89',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 485,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 486,
            color: 'ff7800',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland - Fire-maintained Savanna',
          },
          {
            value: 487,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 488,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 489,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 490,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 491,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 492,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 493,
            color: '0e2e39',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 494,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 495,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 496,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 497,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 498,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 499,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 500,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 501,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 502,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 503,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 504,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 505,
            color: 'b00663',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 506,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 507,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 508,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 509,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 510,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 511,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 512,
            color: 'e9d6f5',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 513,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 514,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 515,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 516,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 517,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 518,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 519,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 520,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 521,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 522,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 523,
            color: '54a075',
            description: 'North American Warm Desert Riparian Systems - Stringers',
          },
          {
            value: 524,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 525,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 526,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 527,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 528,
            color: '00a784',
            description: 'Madrean Encinal',
          },
          {
            value: 529,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 530,
            color: 'a06a1f',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 531,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 532,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 533,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 534,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 535,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 536,
            color: 'ffa000',
            description: 'Sonoran Granite Outcrop Desert Scrub',
          },
          {
            value: 537,
            color: 'b00663',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 538,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 539,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 540,
            color: 'e9d6f5',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 541,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 542,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 543,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 544,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 545,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 546,
            color: '54a075',
            description: 'North American Warm Desert Riparian Systems - Stringers',
          },
          {
            value: 547,
            color: 'ff7878',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 548,
            color: 'a80000',
            description: 'California Coastal Redwood Forest',
          },
          {
            value: 549,
            color: 'f5b595',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 550,
            color: 'ed8b5a',
            description: 'Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 551,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 552,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 553,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 554,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 555,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 556,
            color: 'ff3b7f',
            description: 'Mediterranean California Red Fir Forest',
          },
          {
            value: 557,
            color: 'e2c2a2',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 558,
            color: 'aae3aa',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 559,
            color: 'a4c48f',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 560,
            color: 'ff8500',
            description: 'Northern California Mesic Subalpine Woodland',
          },
          {
            value: 561,
            color: 'c8aa8c',
            description: 'California Maritime Chaparral',
          },
          {
            value: 562,
            color: 'c8be55',
            description: 'California Mesic Chaparral',
          },
          {
            value: 563,
            color: 'd2aa32',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 564,
            color: 'ac69cd',
            description: 'California Xeric Serpentine Chaparral',
          },
          {
            value: 565,
            color: 'f5f6af',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 566,
            color: '449170',
            description: 'California Coastal Live Oak Woodland and Savanna',
          },
          {
            value: 567,
            color: 'b3ffe8',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 568,
            color: '94c2a8',
            description: 'Northern California Coastal Scrub',
          },
          {
            value: 569,
            color: 'cdbcd6',
            description: 'California Mesic Serpentine Grassland',
          },
          {
            value: 570,
            color: 'edf0d8',
            description: 'California Northern Coastal Grassland',
          },
          {
            value: 571,
            color: '00bcff',
            description: 'Mediterranean California Subalpine Meadow',
          },
          {
            value: 572,
            color: 'c7e69e',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 573,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 574,
            color: '444f7d',
            description: 'Pacific Coastal Marsh Systems',
          },
          {
            value: 575,
            color: 'd2eb00',
            description: 'Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral',
          },
          {
            value: 576,
            color: 'edcf00',
            description: 'California Coastal Closed-Cone Conifer Forest and Woodland',
          },
          {
            value: 577,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 578,
            color: 'fff5d7',
            description: 'Mediterranean California Sparsely Vegetated Systems',
          },
          {
            value: 579,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 580,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 581,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 582,
            color: '0e2e39',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 583,
            color: 'f5b595',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 584,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 585,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 586,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 587,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 588,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 589,
            color: 'ff3b7f',
            description: 'Mediterranean California Red Fir Forest - Cascades',
          },
          {
            value: 590,
            color: 'ff9197',
            description: 'Mediterranean California Red Fir Forest - Southern Sierra',
          },
          {
            value: 591,
            color: 'e2c2a2',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 592,
            color: '73004c',
            description: 'Mediterranean California Mesic Serpentine Woodland and Chaparral',
          },
          {
            value: 593,
            color: 'a4c48f',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 594,
            color: 'ff8500',
            description: 'Northern California Mesic Subalpine Woodland',
          },
          {
            value: 595,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 596,
            color: '7fea00',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland - Wet',
          },
          {
            value: 597,
            color: 'b3ff00',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland - Dry',
          },
          {
            value: 598,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 599,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 600,
            color: '8c8c8c',
            description: 'Mediterranean California Alpine Fell-Field',
          },
          {
            value: 601,
            color: '197d5f',
            description: 'Sierra Nevada Alpine Dwarf-Shrubland',
          },
          {
            value: 602,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 603,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 604,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 605,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 606,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 607,
            color: 'c8be55',
            description: 'California Mesic Chaparral',
          },
          {
            value: 608,
            color: 'd2aa32',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 609,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 610,
            color: 'f5f6af',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 611,
            color: 'b3ffe8',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 612,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 613,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 614,
            color: '642b1d',
            description: 'Mediterranean California Alpine Dry Tundra',
          },
          {
            value: 615,
            color: '00bcff',
            description: 'Mediterranean California Subalpine Meadow',
          },
          {
            value: 616,
            color: 'c7e69e',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 617,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 618,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 619,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 620,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 621,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 622,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 623,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 624,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 625,
            color: '0e2e39',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 626,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 627,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 628,
            color: '5f93e5',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 629,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Mesic',
          },
          {
            value: 630,
            color: 'a87800',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Xeric',
          },
          {
            value: 631,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 632,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 633,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 634,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 635,
            color: 'beffe8',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 636,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 637,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 638,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 639,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 640,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 641,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 642,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 643,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 644,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 645,
            color: 'cdf57a',
            description: 'Columbia Basin Foothill and Canyon Dry Grassland',
          },
          {
            value: 646,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 647,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 648,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 649,
            color: 'dcdc00',
            description: 'Columbia Basin Palouse Prairie',
          },
          {
            value: 650,
            color: '828282',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 651,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 652,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 653,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 654,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 655,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 656,
            color: '444f89',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 657,
            color: 'ff7800',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 658,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 659,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 660,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 661,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 662,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 663,
            color: '5f93e5',
            description: 'Northern Rocky Mountain Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 664,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Mesic',
          },
          {
            value: 665,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 666,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 667,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 668,
            color: 'beffe8',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 669,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 670,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 671,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 672,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 673,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 674,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 675,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 676,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 677,
            color: 'cdf57a',
            description: 'Columbia Basin Foothill and Canyon Dry Grassland',
          },
          {
            value: 678,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 679,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 680,
            color: 'dcdc00',
            description: 'Columbia Basin Palouse Prairie',
          },
          {
            value: 681,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 682,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 683,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 684,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 685,
            color: 'ff7800',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 686,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 687,
            color: 'ffd37f',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 688,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 689,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 690,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 691,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 692,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 693,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 694,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 695,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 696,
            color: '13765c',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 697,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland - Basin Big Sagebrush',
          },
          {
            value: 698,
            color: 'ffa3b4',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland - Wyoming Big Sagebrush',
          },
          {
            value: 699,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 700,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 701,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 702,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 703,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 704,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 705,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 706,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 707,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 708,
            color: '828282',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 709,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 710,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 711,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 712,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 713,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 714,
            color: '444f89',
            description: 'Northern Rocky Mountain Conifer Swamp',
          },
          {
            value: 715,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 716,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 717,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 718,
            color: 'fff0be',
            description: 'North Pacific Sparsely Vegetated Systems',
          },
          {
            value: 719,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 720,
            color: 'ff7878',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 721,
            color: '5f9eb4',
            description: 'East Cascades Mesic Montane Mixed-Conifer Forest and Woodland',
          },
          {
            value: 722,
            color: '894444',
            description: 'North Pacific Dry Douglas-fir(-Madrone) Forest and Woodland',
          },
          {
            value: 723,
            color: 'd57fe3',
            description: 'North Pacific Hypermaritime Sitka Spruce Forest',
          },
          {
            value: 724,
            color: 'defcde',
            description: 'North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 725,
            color: 'ff9100',
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 726,
            color: 'aae3aa',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 727,
            color: 'a5e6fc',
            description: 'North Pacific Mountain Hemlock Forest - Wet',
          },
          {
            value: 728,
            color: '72d0f2',
            description: 'North Pacific Mountain Hemlock Forest - Xeric',
          },
          {
            value: 729,
            color: 'f9bdfc',
            description: 'North Pacific Mesic Western Hemlock-Silver Fir Forest',
          },
          {
            value: 730,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 731,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 732,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Mesic',
          },
          {
            value: 733,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 734,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 735,
            color: 'cd6666',
            description: 'East Cascades Oak-Ponderosa Pine Forest and Woodland',
          },
          {
            value: 736,
            color: 'fff7a3',
            description: 'North Pacific Broadleaf Landslide Forest and Shrubland',
          },
          {
            value: 737,
            color: 'beffe8',
            description: 'Columbia Plateau Scabland Shrubland',
          },
          {
            value: 738,
            color: '147d7d',
            description: 'North Pacific Dry and Mesic Alpine Dwarf-Shrubland or Fell-field or Meadow',
          },
          {
            value: 739,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 740,
            color: 'fffa00',
            description: 'North Pacific Avalanche Chute Shrubland',
          },
          {
            value: 741,
            color: 'ff00c5',
            description: 'North Pacific Montane Shrubland',
          },
          {
            value: 742,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 743,
            color: 'd7d79e',
            description: 'Willamette Valley Upland Prairie and Savanna',
          },
          {
            value: 744,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 745,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 746,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 747,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 748,
            color: 'c7e69e',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 749,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 750,
            color: 'b1b37d',
            description: 'North Pacific Lowland Riparian Forest and Shrubland',
          },
          {
            value: 751,
            color: '465589',
            description: 'North Pacific Swamp Systems',
          },
          {
            value: 752,
            color: 'bccfd4',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Wet',
          },
          {
            value: 753,
            color: 'acc2c1',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Dry',
          },
          {
            value: 754,
            color: 'ff7800',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 755,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 756,
            color: 'a7c3a7',
            description: 'North Pacific Alpine and Subalpine Dry Grassland',
          },
          {
            value: 757,
            color: 'f5ba9d',
            description: 'North Pacific Wooded Volcanic Flowage',
          },
          {
            value: 758,
            color: 'd9bdfc',
            description: 'North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest',
          },
          {
            value: 759,
            color: 'd7b09e',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 760,
            color: 'ff7878',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 761,
            color: 'a80000',
            description: 'California Coastal Redwood Forest',
          },
          {
            value: 762,
            color: 'f5b595',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 763,
            color: 'ed8b5a',
            description: 'Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 764,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 765,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 766,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 767,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 768,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 769,
            color: 'ff3b7f',
            description: 'Mediterranean California Red Fir Forest',
          },
          {
            value: 770,
            color: '894444',
            description: 'North Pacific Dry Douglas-fir(-Madrone) Forest and Woodland',
          },
          {
            value: 771,
            color: 'd57fe3',
            description: 'North Pacific Hypermaritime Sitka Spruce Forest',
          },
          {
            value: 772,
            color: 'defcde',
            description: 'North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 773,
            color: 'aae3aa',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 774,
            color: 'a4c48f',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 775,
            color: 'cd6666',
            description: 'East Cascades Oak-Ponderosa Pine Forest and Woodland',
          },
          {
            value: 776,
            color: 'fff7a3',
            description: 'North Pacific Broadleaf Landslide Forest and Shrubland',
          },
          {
            value: 777,
            color: 'd7d79e',
            description: 'Willamette Valley Upland Prairie and Savanna',
          },
          {
            value: 778,
            color: '94c2a8',
            description: 'Northern California Coastal Scrub',
          },
          {
            value: 779,
            color: 'edf0d8',
            description: 'California Northern Coastal Grassland',
          },
          {
            value: 780,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 781,
            color: 'b1b37d',
            description: 'North Pacific Lowland Riparian Forest and Shrubland',
          },
          {
            value: 782,
            color: '465589',
            description: 'North Pacific Swamp Systems',
          },
          {
            value: 783,
            color: 'bccfd4',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Wet',
          },
          {
            value: 784,
            color: 'acc2c1',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Dry',
          },
          {
            value: 785,
            color: 'd2eb00',
            description: 'Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral',
          },
          {
            value: 786,
            color: 'd7b09e',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 787,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 788,
            color: 'fff5d7',
            description: 'Mediterranean California Sparsely Vegetated Systems',
          },
          {
            value: 789,
            color: 'fff0be',
            description: 'North Pacific Sparsely Vegetated Systems',
          },
          {
            value: 790,
            color: 'ff7878',
            description: 'North Pacific Oak Woodland',
          },
          {
            value: 791,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 792,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 793,
            color: '5f9eb4',
            description: 'East Cascades Mesic Montane Mixed-Conifer Forest and Woodland',
          },
          {
            value: 794,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 795,
            color: 'f5b595',
            description: 'Klamath-Siskiyou Lower Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 796,
            color: 'ed8b5a',
            description: 'Klamath-Siskiyou Upper Montane Serpentine Mixed Conifer Woodland',
          },
          {
            value: 797,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 798,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 799,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 800,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 801,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 802,
            color: 'ff3b7f',
            description: 'Mediterranean California Red Fir Forest',
          },
          {
            value: 803,
            color: 'e2c2a2',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 804,
            color: '73004c',
            description: 'Mediterranean California Mesic Serpentine Woodland and Chaparral',
          },
          {
            value: 805,
            color: '894444',
            description: 'North Pacific Dry Douglas-fir(-Madrone) Forest and Woodland',
          },
          {
            value: 806,
            color: 'defcde',
            description: 'North Pacific Maritime Dry-Mesic Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 807,
            color: 'ff9100',
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 808,
            color: 'aae3aa',
            description: 'North Pacific Maritime Mesic-Wet Douglas-fir-Western Hemlock Forest',
          },
          {
            value: 809,
            color: 'a5e6fc',
            description: 'North Pacific Mountain Hemlock Forest - Wet',
          },
          {
            value: 810,
            color: '72d0f2',
            description: 'North Pacific Mountain Hemlock Forest - Xeric',
          },
          {
            value: 811,
            color: 'f9bdfc',
            description: 'North Pacific Mesic Western Hemlock-Silver Fir Forest',
          },
          {
            value: 812,
            color: 'a4c48f',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 813,
            color: 'ff8500',
            description: 'Northern California Mesic Subalpine Woodland',
          },
          {
            value: 814,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest',
          },
          {
            value: 815,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 816,
            color: 'a85500',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Mesic',
          },
          {
            value: 817,
            color: 'a87800',
            description: 'Northern Rocky Mountain Ponderosa Pine Woodland and Savanna - Xeric',
          },
          {
            value: 818,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 819,
            color: '7fea00',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland',
          },
          {
            value: 820,
            color: 'cd6666',
            description: 'East Cascades Oak-Ponderosa Pine Forest and Woodland',
          },
          {
            value: 821,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 822,
            color: 'fff7a3',
            description: 'North Pacific Broadleaf Landslide Forest and Shrubland',
          },
          {
            value: 823,
            color: '147d7d',
            description: 'North Pacific Dry and Mesic Alpine Dwarf-Shrubland or Fell-field or Meadow',
          },
          {
            value: 824,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 825,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 826,
            color: 'c8be55',
            description: 'California Mesic Chaparral',
          },
          {
            value: 827,
            color: 'd2aa32',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 828,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 829,
            color: 'f5f6af',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 830,
            color: 'b3ffe8',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 831,
            color: 'd7d79e',
            description: 'Willamette Valley Upland Prairie and Savanna',
          },
          {
            value: 832,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 833,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 834,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 835,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 836,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 837,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 838,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 839,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 840,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 841,
            color: 'b1b37d',
            description: 'North Pacific Lowland Riparian Forest and Shrubland',
          },
          {
            value: 842,
            color: 'bccfd4',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Wet',
          },
          {
            value: 843,
            color: 'acc2c1',
            description: 'North Pacific Montane Riparian Woodland and Shrubland - Dry',
          },
          {
            value: 844,
            color: 'ff7800',
            description: 'Northern Rocky Mountain Foothill Conifer Wooded Steppe',
          },
          {
            value: 845,
            color: '55ff00',
            description: 'Rocky Mountain Poor-Site Lodgepole Pine Forest',
          },
          {
            value: 846,
            color: 'd2eb00',
            description: 'Klamath-Siskiyou Xeromorphic Serpentine Savanna and Chaparral',
          },
          {
            value: 847,
            color: 'a7c3a7',
            description: 'North Pacific Alpine and Subalpine Dry Grassland',
          },
          {
            value: 848,
            color: 'e6ffe6',
            description: 'Sierran-Intermontane Desert Western White Pine-White Fir Woodland',
          },
          {
            value: 849,
            color: 'f5ba9d',
            description: 'North Pacific Wooded Volcanic Flowage',
          },
          {
            value: 850,
            color: 'd9bdfc',
            description: 'North Pacific Dry-Mesic Silver Fir-Western Hemlock-Douglas-fir Forest',
          },
          {
            value: 851,
            color: 'd7b09e',
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 852,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 853,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 854,
            color: 'c8d1ff',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Ponderosa Pine-Douglas-fir',
          },
          {
            value: 855,
            color: '8fccb1',
            description: 'Northern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest - Lodgepole Pine',
          },
          {
            value: 856,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 857,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 858,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 859,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 860,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 861,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 862,
            color: 'a80084',
            description: 'Northwestern Great Plains Shrubland',
          },
          {
            value: 863,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 864,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 865,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 866,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 867,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 868,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 869,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 870,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 871,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 872,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 873,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 874,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 875,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 876,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 877,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 878,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 879,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 880,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 881,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 882,
            color: '80fb1a',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 883,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 884,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 885,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 886,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 887,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 888,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 889,
            color: '0bbe7f',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 890,
            color: '848cc8',
            description: 'Wyoming Basins Dwarf Sagebrush Shrubland and Steppe',
          },
          {
            value: 891,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland - Basin Big Sagebrush',
          },
          {
            value: 892,
            color: 'ffa3b4',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland - Wyoming Big Sagebrush',
          },
          {
            value: 893,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 894,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland - No True Mountain Mahogany',
          },
          {
            value: 895,
            color: '891987',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland - True Mountain Mahogany',
          },
          {
            value: 896,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 897,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 898,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 899,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 900,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 901,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 902,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 903,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 904,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 905,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 906,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 907,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 908,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 909,
            color: 'fff5d7',
            description: 'Mediterranean California Sparsely Vegetated Systems',
          },
          {
            value: 910,
            color: '77ab57',
            description: 'Central and Southern California Mixed Evergreen Woodland',
          },
          {
            value: 911,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 912,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 913,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 914,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 915,
            color: 'a4c48f',
            description: 'Mediterranean California Mixed Evergreen Forest',
          },
          {
            value: 916,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 917,
            color: 'c8be55',
            description: 'California Mesic Chaparral',
          },
          {
            value: 918,
            color: 'f5f6af',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 919,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 920,
            color: 'e68282',
            description: 'California Central Valley Mixed Oak Savanna',
          },
          {
            value: 921,
            color: 'b3ffe8',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 922,
            color: 'a3ff73',
            description: 'California Central Valley and Southern Coastal Grassland',
          },
          {
            value: 923,
            color: 'c7e69e',
            description: 'North Pacific Montane Grassland',
          },
          {
            value: 924,
            color: '3eabd7',
            description: 'California Central Valley Riparian Woodland and Shrubland',
          },
          {
            value: 925,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 926,
            color: '444f7d',
            description: 'Pacific Coastal Marsh Systems',
          },
          {
            value: 927,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 928,
            color: '77ab57',
            description: 'Central and Southern California Mixed Evergreen Woodland',
          },
          {
            value: 929,
            color: 'a80000',
            description: 'California Coastal Redwood Forest',
          },
          {
            value: 930,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 931,
            color: '9ebbd7',
            description: 'Mediterranean California Dry-Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 932,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 933,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 934,
            color: 'b45091',
            description: 'Mediterranean California Lower Montane Black Oak-Conifer Forest and Woodland',
          },
          {
            value: 935,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 936,
            color: '73004c',
            description: 'Mediterranean California Mesic Serpentine Woodland and Chaparral',
          },
          {
            value: 937,
            color: '7fea00',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland',
          },
          {
            value: 938,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 939,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 940,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 941,
            color: '9ed7c2',
            description: 'Southern California Coastal Scrub',
          },
          {
            value: 942,
            color: 'c8aa8c',
            description: 'California Maritime Chaparral',
          },
          {
            value: 943,
            color: 'c8be55',
            description: 'California Mesic Chaparral',
          },
          {
            value: 944,
            color: 'd2aa32',
            description: 'California Montane Woodland and Chaparral',
          },
          {
            value: 945,
            color: 'ac69cd',
            description: 'California Xeric Serpentine Chaparral',
          },
          {
            value: 946,
            color: 'f5f6af',
            description: 'Northern and Central California Dry-Mesic Chaparral',
          },
          {
            value: 947,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 948,
            color: 'e9d6f5',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 949,
            color: 'e2f5ae',
            description: 'Southern California Dry-Mesic Chaparral',
          },
          {
            value: 950,
            color: 'e68282',
            description: 'California Central Valley Mixed Oak Savanna',
          },
          {
            value: 951,
            color: '449170',
            description: 'California Coastal Live Oak Woodland and Savanna',
          },
          {
            value: 952,
            color: 'b3ffe8',
            description: 'California Lower Montane Blue Oak-Foothill Pine Woodland and Savanna',
          },
          {
            value: 953,
            color: '44a082',
            description: 'Southern California Oak Woodland and Savanna',
          },
          {
            value: 954,
            color: '94c2a8',
            description: 'Northern California Coastal Scrub',
          },
          {
            value: 955,
            color: 'a3ff73',
            description: 'California Central Valley and Southern Coastal Grassland',
          },
          {
            value: 956,
            color: 'cdbcd6',
            description: 'California Mesic Serpentine Grassland',
          },
          {
            value: 957,
            color: 'edf0d8',
            description: 'California Northern Coastal Grassland',
          },
          {
            value: 958,
            color: '3eabd7',
            description: 'California Central Valley Riparian Woodland and Shrubland',
          },
          {
            value: 959,
            color: '4196a7',
            description: 'California Montane Riparian Systems',
          },
          {
            value: 960,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 961,
            color: '444f7d',
            description: 'Pacific Coastal Marsh Systems',
          },
          {
            value: 962,
            color: 'edcf00',
            description: 'California Coastal Closed-Cone Conifer Forest and Woodland',
          },
          {
            value: 963,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 964,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 965,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 966,
            color: 'ffd37f',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 967,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 968,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 969,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 970,
            color: '80fb1a',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 971,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 972,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 973,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 974,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 975,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 976,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 977,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland - Low Elevation',
          },
          {
            value: 978,
            color: 'c8e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland - High Elevation',
          },
          {
            value: 979,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 980,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 981,
            color: '13765c',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 982,
            color: '349bcf',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 983,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 984,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 985,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 986,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 987,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 988,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 989,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 990,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland  - Continuous',
          },
          {
            value: 991,
            color: '66cdab',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland - Patchy',
          },
          {
            value: 992,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 993,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 994,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 995,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe - Mountain Big Sagebrush',
          },
          {
            value: 996,
            color: 'ffc5bf',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe - Low Sagebrush',
          },
          {
            value: 997,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 998,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 999,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 1000,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 1001,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1002,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1003,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 1004,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1005,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1006,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1007,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1008,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 1009,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1010,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1011,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 1012,
            color: '80fb1a',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 1013,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1014,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1015,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1016,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1017,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 1018,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1019,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland - Low Elevation',
          },
          {
            value: 1020,
            color: 'c8e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland - High Elevation',
          },
          {
            value: 1021,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1022,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 1023,
            color: '0bbe7f',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 1024,
            color: '349bcf',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 1025,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1026,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1027,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 1028,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1029,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 1030,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 1031,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 1032,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 1033,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1034,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 1035,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1036,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1037,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe - Mountain Big Sagebrush',
          },
          {
            value: 1038,
            color: 'ffc5bf',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe - Low Sagebrush',
          },
          {
            value: 1039,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1040,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1041,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1042,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1043,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1044,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1045,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1046,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1047,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 1048,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1049,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 1050,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 1051,
            color: '0e2e39',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1052,
            color: '5462a8',
            description: 'Mediterranean California Mesic Mixed Conifer Forest and Woodland',
          },
          {
            value: 1053,
            color: 'dc6464',
            description: 'Mediterranean California Mixed Oak Woodland',
          },
          {
            value: 1054,
            color: 'a74600',
            description: 'California Montane Jeffrey Pine(-Ponderosa Pine) Woodland',
          },
          {
            value: 1055,
            color: 'e2c2a2',
            description: 'Mediterranean California Subalpine Woodland',
          },
          {
            value: 1056,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1057,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1058,
            color: '7fea00',
            description: 'Sierra Nevada Subalpine Lodgepole Pine Forest and Woodland',
          },
          {
            value: 1059,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1060,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 1061,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1062,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1063,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 1064,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 1065,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 1066,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 1067,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 1068,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1069,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1070,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1071,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1072,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 1073,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1074,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 1075,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1076,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1077,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1078,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1079,
            color: 'ffd37f',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 1080,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1081,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 1082,
            color: '0e2e39',
            description: 'Inter-Mountain Basins Subalpine Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1083,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1084,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1085,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1086,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1087,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1088,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1089,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 1090,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 1091,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1092,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1093,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 1094,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1095,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 1096,
            color: 'aefaff',
            description: 'Great Basin Semi-Desert Chaparral',
          },
          {
            value: 1097,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 1098,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1099,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 1100,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 1101,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 1102,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1103,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1104,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1105,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1106,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 1107,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1108,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 1109,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1110,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1111,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1112,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1113,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1114,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1115,
            color: '00a784',
            description: 'Madrean Encinal',
          },
          {
            value: 1116,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 1117,
            color: 'a06a1f',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 1118,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1119,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1120,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1121,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1122,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1123,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland - Low Elevation',
          },
          {
            value: 1124,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 1125,
            color: '0bbe7f',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 1126,
            color: '349bcf',
            description: 'Colorado Plateau Blackbrush-Mormon-tea Shrubland',
          },
          {
            value: 1127,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1128,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1129,
            color: '86db18',
            description: 'Southern Colorado Plateau Sand Shrubland',
          },
          {
            value: 1130,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 1131,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 1132,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1133,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 1134,
            color: 'cf9d8f',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 1135,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1136,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1137,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 1138,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1139,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1140,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1141,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 1142,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1143,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1144,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1145,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 1146,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1147,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1148,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 1149,
            color: '80fb1a',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 1150,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1151,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1152,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1153,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1154,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 1155,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1156,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1157,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1158,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1159,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 1160,
            color: '13765c',
            description: 'Rocky Mountain Alpine Dwarf-Shrubland',
          },
          {
            value: 1161,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1162,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1163,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1164,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 1165,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1166,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 1167,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1168,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1169,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1170,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1171,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1172,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1173,
            color: '828282',
            description: 'Rocky Mountain Alpine Fell-Field',
          },
          {
            value: 1174,
            color: '5d2b1d',
            description: 'Rocky Mountain Alpine Turf',
          },
          {
            value: 1175,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 1176,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1177,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1178,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1179,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1180,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1181,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1182,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1183,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 1184,
            color: '00a784',
            description: 'Madrean Encinal',
          },
          {
            value: 1185,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 1186,
            color: 'a06a1f',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 1187,
            color: '498039',
            description: 'Madrean Upper Montane Conifer-Oak Forest and Woodland',
          },
          {
            value: 1188,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1189,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1190,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1191,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1192,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 1193,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1194,
            color: 'e87f69',
            description: 'Chihuahuan Succulent Desert Scrub',
          },
          {
            value: 1195,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1196,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1197,
            color: 'd80649',
            description: 'Mojave Mid-Elevation Mixed Desert Scrub',
          },
          {
            value: 1198,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 1199,
            color: 'b00663',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 1200,
            color: 'f5a27a',
            description: 'Chihuahuan Mixed Desert and Thorn Scrub',
          },
          {
            value: 1201,
            color: 'ff0000',
            description: 'Colorado Plateau Pinyon-Juniper Shrubland',
          },
          {
            value: 1202,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 1203,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1204,
            color: 'e9d6f5',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 1205,
            color: '897044',
            description: 'Inter-Mountain Basins Juniper Savanna',
          },
          {
            value: 1206,
            color: 'cf9d8f',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 1207,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1208,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 1209,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1210,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1211,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1212,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 1213,
            color: '54a075',
            description: 'North American Warm Desert Riparian Systems - Stringers',
          },
          {
            value: 1214,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1215,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1216,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1217,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 1218,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1219,
            color: 'ffd37f',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 1220,
            color: '0ef562',
            description: 'Columbia Plateau Western Juniper Woodland and Savanna',
          },
          {
            value: 1221,
            color: '734c00',
            description: 'Great Basin Pinyon-Juniper Woodland',
          },
          {
            value: 1222,
            color: 'ffaa00',
            description: 'Northern Rocky Mountain Subalpine Woodland and Parkland',
          },
          {
            value: 1223,
            color: '80fb1a',
            description: 'Rocky Mountain Lodgepole Pine Forest',
          },
          {
            value: 1224,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1225,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1226,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1227,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 1228,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1229,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1230,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1231,
            color: '39c2cf',
            description: 'Great Basin Xeric Mixed Sagebrush Shrubland',
          },
          {
            value: 1232,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1233,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1234,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1235,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 1236,
            color: 'ebdaea',
            description: 'Columbia Plateau Steppe and Grassland',
          },
          {
            value: 1237,
            color: '848cad',
            description: 'Columbia Plateau Low Sagebrush Steppe',
          },
          {
            value: 1238,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1239,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1240,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1241,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1242,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 1243,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1244,
            color: '9a9c75',
            description: 'Inter-Mountain Basins Montane Riparian Systems',
          },
          {
            value: 1245,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1246,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1247,
            color: '4e4e4e',
            description: 'Rocky Mountain Alpine/Montane Sparsely Vegetated Systems',
          },
          {
            value: 1248,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 1249,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1250,
            color: '00734c',
            description: 'Northwestern Great Plains Highland White Spruce Woodland',
          },
          {
            value: 1251,
            color: '66cdab',
            description: 'Rocky Mountain Foothill Limber Pine-Juniper Woodland',
          },
          {
            value: 1252,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1253,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1254,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1255,
            color: '38a800',
            description: 'Rocky Mountain Subalpine Mesic-Wet Spruce-Fir Forest and Woodland',
          },
          {
            value: 1256,
            color: 'e3dfa2',
            description: 'Rocky Mountain Subalpine-Montane Limber-Bristlecone Pine Woodland',
          },
          {
            value: 1257,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1258,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1259,
            color: '0bbe7f',
            description: 'Inter-Mountain Basins Mat Saltbush Shrubland',
          },
          {
            value: 1260,
            color: '848cc8',
            description: 'Wyoming Basins Dwarf Sagebrush Shrubland and Steppe',
          },
          {
            value: 1261,
            color: 'a80084',
            description: 'Northwestern Great Plains Shrubland',
          },
          {
            value: 1262,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1263,
            color: '894450',
            description: 'Northern Rocky Mountain Montane-Foothill Deciduous Shrubland',
          },
          {
            value: 1264,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1265,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1266,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1267,
            color: 'abcd66',
            description: 'Northern Rocky Mountain Lower Montane-Foothill-Valley Grassland',
          },
          {
            value: 1268,
            color: 'a7cdc3',
            description: 'Northern Rocky Mountain Subalpine-Upper Montane Grassland',
          },
          {
            value: 1269,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 1270,
            color: '00c5ff',
            description: 'Rocky Mountain Subalpine-Montane Mesic Meadow',
          },
          {
            value: 1271,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1272,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1273,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1274,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1275,
            color: '31a5a7',
            description: 'Rocky Mountain Subalpine/Upper Montane Riparian Systems',
          },
          {
            value: 1276,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1277,
            color: 'd67000',
            description: 'Middle Rocky Mountain Montane Douglas-fir Forest and Woodland',
          },
          {
            value: 1278,
            color: 'bd6a40',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna - Low Elevation Woodland',
          },
          {
            value: 1279,
            color: 'ffaf87',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna - Savanna',
          },
          {
            value: 1280,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 1281,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 1282,
            color: 'a80084',
            description: 'Northwestern Great Plains Shrubland',
          },
          {
            value: 1283,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1284,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 1285,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1286,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1287,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1288,
            color: 'bd6a40',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna - Low Elevation Woodland',
          },
          {
            value: 1289,
            color: 'ffaf87',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna - Savanna',
          },
          {
            value: 1290,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 1291,
            color: '9c64a3',
            description: 'Great Plains Prairie Pothole',
          },
          {
            value: 1292,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1293,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 1294,
            color: 'e6cd9c',
            description: 'Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest',
          },
          {
            value: 1295,
            color: 'a87000',
            description: 'Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1296,
            color: '4e9c1a',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland',
          },
          {
            value: 1297,
            color: '87ba18',
            description: 'Atlantic Coastal Plain Upland Longleaf Pine Woodland',
          },
          {
            value: 1298,
            color: '98b000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 1299,
            color: '4cba0a',
            description: 'Florida Longleaf Pine Sandhill',
          },
          {
            value: 1300,
            color: 'bf9747',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 1301,
            color: 'd682ff',
            description: 'East Gulf Coastal Plain Maritime Forest',
          },
          {
            value: 1302,
            color: 'ba82ff',
            description: 'Southern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1303,
            color: 'ffc800',
            description: 'Florida Peninsula Inland Scrub',
          },
          {
            value: 1304,
            color: 'd1ffb3',
            description: 'Southern Atlantic Coastal Plain Wet Pine Savanna and Flatwoods',
          },
          {
            value: 1305,
            color: '96f567',
            description: 'Central Florida Pine Flatwoods',
          },
          {
            value: 1306,
            color: '95e376',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods',
          },
          {
            value: 1307,
            color: 'a80a00',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome',
          },
          {
            value: 1308,
            color: 'bee8ff',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 1309,
            color: '444f91',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 1310,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1311,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1312,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1313,
            color: 'ffd978',
            description: 'East Gulf Coastal Plain Savanna and Wet Prairie',
          },
          {
            value: 1314,
            color: 'f0ff5e',
            description: 'Floridian Highlands Freshwater Marsh',
          },
          {
            value: 1315,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1316,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 1317,
            color: '807900',
            description: 'South Florida Hardwood Hammock',
          },
          {
            value: 1318,
            color: 'f773ff',
            description: 'Southwest Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 1319,
            color: 'e45eff',
            description: 'Southeast Florida Coastal Strand and Maritime Hammock',
          },
          {
            value: 1320,
            color: '4cba0a',
            description: 'Florida Longleaf Pine Sandhill',
          },
          {
            value: 1321,
            color: 'd6aa66',
            description: 'South Florida Pine Rockland',
          },
          {
            value: 1322,
            color: 'ffc800',
            description: 'Florida Peninsula Inland Scrub',
          },
          {
            value: 1323,
            color: 'ffd6d6',
            description: 'Florida Dry Prairie',
          },
          {
            value: 1324,
            color: 'e0007b',
            description: 'South Florida Dwarf Cypress Savanna',
          },
          {
            value: 1325,
            color: 'a2e68c',
            description: 'South Florida Pine Flatwoods',
          },
          {
            value: 1326,
            color: 'c80a00',
            description: 'South Florida Cypress Dome',
          },
          {
            value: 1327,
            color: '96f567',
            description: 'Central Florida Pine Flatwoods',
          },
          {
            value: 1328,
            color: '95e376',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods',
          },
          {
            value: 1329,
            color: 'a80a00',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome',
          },
          {
            value: 1330,
            color: 'bee8ff',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 1331,
            color: '00d9ff',
            description: 'Caribbean Coastal Wetland Systems',
          },
          {
            value: 1332,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1333,
            color: '5cedc9',
            description: 'Caribbean Swamp Systems',
          },
          {
            value: 1334,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1335,
            color: 'd4ffed',
            description: 'South Florida Everglades Sawgrass Marsh',
          },
          {
            value: 1336,
            color: 'f0ff5e',
            description: 'Floridian Highlands Freshwater Marsh',
          },
          {
            value: 1337,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1338,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1339,
            color: 'cdaa66',
            description: 'Colorado Plateau Pinyon-Juniper Woodland',
          },
          {
            value: 1340,
            color: '00a784',
            description: 'Madrean Encinal',
          },
          {
            value: 1341,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 1342,
            color: 'a06a1f',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 1343,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1344,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1345,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1346,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1347,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1348,
            color: 'df73ff',
            description: 'Chihuahuan Creosotebush Desert Scrub',
          },
          {
            value: 1349,
            color: 'f4bf00',
            description: 'Chihuahuan Mixed Salt Desert Scrub',
          },
          {
            value: 1350,
            color: 'e87f69',
            description: 'Chihuahuan Succulent Desert Scrub',
          },
          {
            value: 1351,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1352,
            color: '349ab8',
            description: 'Sonora-Mojave Creosotebush-White Bursage Desert Scrub',
          },
          {
            value: 1353,
            color: 'f5de6e',
            description: 'Sonora-Mojave Mixed Salt Desert Scrub',
          },
          {
            value: 1354,
            color: 'b00663',
            description: 'Sonoran Mid-Elevation Desert Scrub',
          },
          {
            value: 1355,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1356,
            color: 'f5a27a',
            description: 'Chihuahuan Mixed Desert Shrubland',
          },
          {
            value: 1357,
            color: 'cd8966',
            description: 'Chihuahuan Grama Grass-Creosote Steppe',
          },
          {
            value: 1358,
            color: '74d4b4',
            description: 'Madrean Oriental Chaparral',
          },
          {
            value: 1359,
            color: 'adfad3',
            description: 'Mogollon Chaparral',
          },
          {
            value: 1360,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1361,
            color: 'ffc5ad',
            description: 'Sonora-Mojave Semi-Desert Chaparral',
          },
          {
            value: 1362,
            color: 'e9d6f5',
            description: 'Sonoran Paloverde-Mixed Cacti Desert Scrub',
          },
          {
            value: 1363,
            color: 'cf9d8f',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 1364,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1365,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 1366,
            color: '91e600',
            description: 'Chihuahuan Gypsophilous Grassland and Steppe',
          },
          {
            value: 1367,
            color: 'c29ed7',
            description: 'Inter-Mountain Basins Semi-Desert Shrub-Steppe',
          },
          {
            value: 1368,
            color: 'e5dd85',
            description: 'Chihuahuan Sandy Plains Semi-Desert Grassland',
          },
          {
            value: 1369,
            color: 'b9aed3',
            description: 'Inter-Mountain Basins Semi-Desert Grassland',
          },
          {
            value: 1370,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1371,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1372,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1373,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 1374,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1375,
            color: 'c7d79e',
            description: 'Chihuahuan Loamy Plains Desert Grassland',
          },
          {
            value: 1376,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 1377,
            color: 'fff2bd',
            description: 'North American Warm Desert Sparsely Vegetated Systems',
          },
          {
            value: 1378,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 1379,
            color: 'a06a1f',
            description: 'Madrean Pinyon-Juniper Woodland',
          },
          {
            value: 1380,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1381,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1382,
            color: 'df73ff',
            description: 'Chihuahuan Creosotebush Desert Scrub',
          },
          {
            value: 1383,
            color: 'f4bf00',
            description: 'Chihuahuan Mixed Salt Desert Scrub',
          },
          {
            value: 1384,
            color: 'e54563',
            description: 'Chihuahuan Stabilized Coppice Dune and Sand Flat Scrub',
          },
          {
            value: 1385,
            color: 'e87f69',
            description: 'Chihuahuan Succulent Desert Scrub',
          },
          {
            value: 1386,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1387,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1388,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 1389,
            color: 'f5a27a',
            description: 'Chihuahuan Mixed Desert and Thorn Scrub',
          },
          {
            value: 1390,
            color: '74d4b4',
            description: 'Madrean Oriental Chaparral',
          },
          {
            value: 1391,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1392,
            color: 'cf9d8f',
            description: 'Madrean Juniper Savanna',
          },
          {
            value: 1393,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1394,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 1395,
            color: '91e600',
            description: 'Chihuahuan Gypsophilous Grassland and Steppe',
          },
          {
            value: 1396,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1397,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1398,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 1399,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1400,
            color: 'ffcb7d',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 1401,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems - Playa',
          },
          {
            value: 1402,
            color: 'c7d79e',
            description: 'Chihuahuan Loamy Plains Desert Grassland',
          },
          {
            value: 1403,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland - Tobosa Grassland',
          },
          {
            value: 1404,
            color: '64964b',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland - Alkali Sacaton',
          },
          {
            value: 1405,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland',
          },
          {
            value: 1406,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1407,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1408,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub',
          },
          {
            value: 1409,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1410,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1411,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1412,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1413,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna',
          },
          {
            value: 1414,
            color: 'e600a9',
            description: 'Inter-Mountain Basins Montane Sagebrush Steppe',
          },
          {
            value: 1415,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 1416,
            color: '89cd66',
            description: 'Western Great Plains Foothill and Piedmont Grassland',
          },
          {
            value: 1417,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1418,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1419,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1420,
            color: 'c4b29c',
            description: 'Northwestern Great Plains Canyon',
          },
          {
            value: 1421,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1422,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 1423,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1424,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1425,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1426,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 1427,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1428,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1429,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1430,
            color: 'ffcb7d',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 1431,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems - Playa',
          },
          {
            value: 1432,
            color: '5200c9',
            description: 'Western Great Plains Depressional Wetland Systems - Saline',
          },
          {
            value: 1433,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland - Tobosa Grassland',
          },
          {
            value: 1434,
            color: '64964b',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland - Alkali Sacaton',
          },
          {
            value: 1435,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1436,
            color: 'db45df',
            description: 'West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 1437,
            color: '707f00',
            description: 'West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland',
          },
          {
            value: 1438,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 1439,
            color: 'd1d900',
            description: 'West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland',
          },
          {
            value: 1440,
            color: 'ff7f7f',
            description: 'Southern Blackland Tallgrass Prairie',
          },
          {
            value: 1441,
            color: 'ff006e',
            description: 'West Gulf Coastal Plain Northern Calcareous Prairie',
          },
          {
            value: 1442,
            color: 'ff249e',
            description: 'West Gulf Coastal Plain Southern Calcareous Prairie',
          },
          {
            value: 1443,
            color: 'dba3df',
            description: 'Texas-Louisiana Coastal Prairie',
          },
          {
            value: 1444,
            color: '44f200',
            description: 'West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 1445,
            color: '63eb61',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 1446,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1447,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1448,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1449,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1450,
            color: '267300',
            description: 'West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods',
          },
          {
            value: 1451,
            color: 'cf940a',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 1452,
            color: 'e6cd9c',
            description: 'Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest',
          },
          {
            value: 1453,
            color: 'a87000',
            description: 'Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1454,
            color: '4e9c1a',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland',
          },
          {
            value: 1455,
            color: '87ba18',
            description: 'Atlantic Coastal Plain Upland Longleaf Pine Woodland',
          },
          {
            value: 1456,
            color: 'bf9747',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 1457,
            color: 'ed00e5',
            description: 'Central Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1458,
            color: 'ba82ff',
            description: 'Southern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1459,
            color: '640046',
            description: 'Southern Atlantic Coastal Plain Dune and Maritime Grassland',
          },
          {
            value: 1460,
            color: '8fed29',
            description: 'Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 1461,
            color: 'd1ffb3',
            description: 'Southern Atlantic Coastal Plain Wet Pine Savanna and Flatwoods',
          },
          {
            value: 1462,
            color: 'ff7d00',
            description: 'Atlantic Coastal Plain Peatland Pocosin and Canebrake',
          },
          {
            value: 1463,
            color: 'ffe84f',
            description: 'Atlantic Coastal Plain Clay-Based Carolina Bay Wetland',
          },
          {
            value: 1464,
            color: '444f91',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 1465,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1466,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1467,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1468,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1469,
            color: '63d6ff',
            description: 'Central Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest',
          },
          {
            value: 1470,
            color: 'ffffbe',
            description: 'Inter-Mountain Basins Sparsely Vegetated Systems',
          },
          {
            value: 1471,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 1472,
            color: 'ffff73',
            description: 'Rocky Mountain Aspen Forest and Woodland',
          },
          {
            value: 1473,
            color: 'ffd37f',
            description: 'Rocky Mountain Bigtooth Maple Ravine Woodland',
          },
          {
            value: 1474,
            color: 'a7bd1e',
            description: 'Madrean Lower Montane Pine-Oak Forest and Woodland',
          },
          {
            value: 1475,
            color: 'bed2ff',
            description: 'Southern Rocky Mountain Dry-Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1476,
            color: '7395e6',
            description: 'Southern Rocky Mountain Mesic Montane Mixed Conifer Forest and Woodland',
          },
          {
            value: 1477,
            color: 'a83800',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland - South',
          },
          {
            value: 1478,
            color: '941a36',
            description: 'Southern Rocky Mountain Ponderosa Pine Woodland - North',
          },
          {
            value: 1479,
            color: 'd3ffbe',
            description: 'Rocky Mountain Subalpine Dry-Mesic Spruce-Fir Forest and Woodland',
          },
          {
            value: 1480,
            color: 'b78a2e',
            description: 'Southern Rocky Mountain Pinyon-Juniper Woodland',
          },
          {
            value: 1481,
            color: 'e6e600',
            description: 'Inter-Mountain Basins Aspen-Mixed Conifer Forest and Woodland',
          },
          {
            value: 1482,
            color: '9eaad7',
            description: 'Colorado Plateau Mixed Low Sagebrush Shrubland',
          },
          {
            value: 1483,
            color: 'f5ca7a',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub - South',
          },
          {
            value: 1484,
            color: 'e09691',
            description: 'Inter-Mountain Basins Mixed Salt Desert Scrub - North',
          },
          {
            value: 1485,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1486,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1487,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 1488,
            color: '73ffdf',
            description: 'Rocky Mountain Gambel Oak-Mixed Montane Shrubland',
          },
          {
            value: 1489,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1490,
            color: 'ff5500',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna - South',
          },
          {
            value: 1491,
            color: 'ed7d21',
            description: 'Southern Rocky Mountain Ponderosa Pine Savanna - North',
          },
          {
            value: 1492,
            color: '875614',
            description: 'Southern Rocky Mountain Juniper Woodland and Savanna',
          },
          {
            value: 1493,
            color: 'ffddd8',
            description: 'Apacherian-Chihuahuan Semi-Desert Grassland and Steppe',
          },
          {
            value: 1494,
            color: '91e600',
            description: 'Chihuahuan Gypsophilous Grassland and Steppe',
          },
          {
            value: 1495,
            color: 'a7cdb2',
            description: 'Southern Rocky Mountain Montane-Subalpine Grassland',
          },
          {
            value: 1496,
            color: '89cd66',
            description: 'Western Great Plains Foothill and Piedmont Grassland',
          },
          {
            value: 1497,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1498,
            color: 'e1e1e1',
            description: 'Inter-Mountain Basins Greasewood Flat',
          },
          {
            value: 1499,
            color: '7b7c5d',
            description: 'Rocky Mountain Montane Riparian Systems',
          },
          {
            value: 1500,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1501,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1502,
            color: 'c7d79e',
            description: 'Chihuahuan Loamy Plains Desert Grassland',
          },
          {
            value: 1503,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 1504,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1505,
            color: 'db45df',
            description: 'West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 1506,
            color: '707f00',
            description: 'West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland',
          },
          {
            value: 1507,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 1508,
            color: '6b3624',
            description: 'Mississippi Delta Maritime Forest',
          },
          {
            value: 1509,
            color: 'dba3df',
            description: 'Texas-Louisiana Coastal Prairie',
          },
          {
            value: 1510,
            color: '44f200',
            description: 'West Gulf Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 1511,
            color: '63eb61',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 1512,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1513,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1514,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1515,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1516,
            color: 'ab6138',
            description: 'Gulf and Atlantic Coastal Plain Sparsely Vegetated Systems',
          },
          {
            value: 1517,
            color: '3ef533',
            description: 'Southern Crowley`s Ridge Mesic Loess Slope Forest',
          },
          {
            value: 1518,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1519,
            color: 'e8a1d4',
            description: 'East Gulf Coastal Plain Northern Loess Bluff Forest',
          },
          {
            value: 1520,
            color: 'a80836',
            description: 'East Gulf Coastal Plain Southern Loess Bluff Forest',
          },
          {
            value: 1521,
            color: '707f00',
            description: 'West Gulf Coastal Plain Upland Longleaf Pine Forest and Woodland',
          },
          {
            value: 1522,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 1523,
            color: 'dec48a',
            description: 'Lower Mississippi River Dune Woodland and Forest',
          },
          {
            value: 1524,
            color: 'ff249e',
            description: 'West Gulf Coastal Plain Southern Calcareous Prairie',
          },
          {
            value: 1525,
            color: 'e3e35c',
            description: 'Lower Mississippi Alluvial Plain Grand Prairie',
          },
          {
            value: 1526,
            color: '63eb61',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 1527,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1528,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1529,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1530,
            color: '006b52',
            description: 'Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest',
          },
          {
            value: 1531,
            color: 'ca7af5',
            description: 'Northern Crowley`s Ridge Sand Forest',
          },
          {
            value: 1532,
            color: '620075',
            description: 'Lower Mississippi River Flatwoods',
          },
          {
            value: 1561,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1562,
            color: '4ce696',
            description: 'Laurentian-Acadian Northern Hardwoods Forest - Hemlock',
          },
          {
            value: 1563,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1564,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 1565,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 1566,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 1567,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1568,
            color: '93c272',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Inland',
          },
          {
            value: 1569,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1570,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1571,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 1572,
            color: '994200',
            description: 'Laurentian Pine-Oak Barrens',
          },
          {
            value: 1573,
            color: '994264',
            description: 'Laurentian-Acadian Jack Pine Barrens and Forest',
          },
          {
            value: 1574,
            color: 'e3eb75',
            description: 'Great Lakes Alvar',
          },
          {
            value: 1575,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1576,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 1577,
            color: '45459c',
            description: 'Eastern Boreal Floodplain',
          },
          {
            value: 1578,
            color: 'b50000',
            description: 'Great Lakes Wooded Dune and Swale',
          },
          {
            value: 1579,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1580,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1581,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1582,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1583,
            color: 'e8bdff',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp',
          },
          {
            value: 1584,
            color: '7af5ca',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 1585,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1586,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1587,
            color: '6a7500',
            description: 'Paleozoic Plateau Bluff and Talus',
          },
          {
            value: 1588,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1589,
            color: '4ce696',
            description: 'Laurentian-Acadian Northern Hardwoods Forest - Hemlock',
          },
          {
            value: 1590,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1591,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 1592,
            color: 'dcf000',
            description: 'Eastern Great Plains Tallgrass Aspen Parkland',
          },
          {
            value: 1593,
            color: 'ff8c8c',
            description: 'Boreal Jack Pine-Black Spruce Forest',
          },
          {
            value: 1594,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1595,
            color: 'ffa77f',
            description: 'Laurentian-Acadian Northern Pine Forest',
          },
          {
            value: 1596,
            color: '93c272',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Inland',
          },
          {
            value: 1597,
            color: '6e8946',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Coastal',
          },
          {
            value: 1598,
            color: 'ffff91',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Aspen-Birch',
          },
          {
            value: 1599,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1600,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 1601,
            color: '994200',
            description: 'Laurentian Pine-Oak Barrens',
          },
          {
            value: 1602,
            color: '994264',
            description: 'Laurentian-Acadian Jack Pine Barrens and Forest',
          },
          {
            value: 1603,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1604,
            color: 'b8841d',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 1605,
            color: '45459c',
            description: 'Eastern Boreal Floodplain',
          },
          {
            value: 1606,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1607,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1608,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1609,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1610,
            color: 'e8bdff',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp',
          },
          {
            value: 1611,
            color: '7af5ca',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 1612,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1613,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1614,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1615,
            color: '4ce696',
            description: 'Laurentian-Acadian Northern Hardwoods Forest - Hemlock',
          },
          {
            value: 1616,
            color: '266900',
            description: 'Northern Sugar Maple-Basswood Forest',
          },
          {
            value: 1617,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1618,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 1619,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 1620,
            color: 'ff8c8c',
            description: 'Great Lakes Pine Barrens',
          },
          {
            value: 1621,
            color: '87c872',
            description: 'Great Lakes Spruce-Fir',
          },
          {
            value: 1622,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1623,
            color: '93c272',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Inland',
          },
          {
            value: 1624,
            color: '6e8946',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Coastal',
          },
          {
            value: 1625,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1626,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1627,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 1628,
            color: '994200',
            description: 'Laurentian Pine-Oak Barrens',
          },
          {
            value: 1629,
            color: '994264',
            description: 'Laurentian-Acadian Jack Pine Barrens and Forest',
          },
          {
            value: 1630,
            color: 'ebff00',
            description: 'Great Lakes Wet-Mesic Lakeplain Prairie',
          },
          {
            value: 1631,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1632,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 1633,
            color: '45459c',
            description: 'Eastern Boreal Floodplain',
          },
          {
            value: 1634,
            color: 'b50000',
            description: 'Great Lakes Wooded Dune and Swale',
          },
          {
            value: 1635,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1636,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1637,
            color: '6a008a',
            description: 'Boreal Acid Peatland Systems',
          },
          {
            value: 1638,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1639,
            color: 'e8bdff',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp',
          },
          {
            value: 1640,
            color: '7af5ca',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 1641,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1642,
            color: 'dc0000',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 1643,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 1644,
            color: 'f5f596',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 1645,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1646,
            color: 'fff538',
            description: 'Boreal Aspen-Birch Forest',
          },
          {
            value: 1647,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1648,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 1649,
            color: 'dcf000',
            description: 'Eastern Great Plains Tallgrass Aspen Parkland',
          },
          {
            value: 1650,
            color: '93c272',
            description: 'Boreal White Spruce-Fir-Hardwood Forest - Inland',
          },
          {
            value: 1651,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 1652,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1653,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1654,
            color: 'b8841d',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 1655,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 1656,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1657,
            color: '9c64a3',
            description: 'Great Plains Prairie Pothole',
          },
          {
            value: 1658,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1659,
            color: 'dc0000',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 1660,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 1661,
            color: 'f5f596',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 1662,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1663,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1664,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 1665,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 1666,
            color: 'dcf000',
            description: 'Eastern Great Plains Tallgrass Aspen Parkland',
          },
          {
            value: 1667,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 1668,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1669,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1670,
            color: 'b8841d',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 1671,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 1672,
            color: '9c64a3',
            description: 'Great Plains Prairie Pothole',
          },
          {
            value: 1673,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1674,
            color: 'ffebbe',
            description: 'Western Great Plains Sparsely Vegetated Systems',
          },
          {
            value: 1675,
            color: 'dc0000',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 1676,
            color: 'bf13e6',
            description: 'Inter-Mountain Basins Curl-leaf Mountain Mahogany Woodland and Shrubland',
          },
          {
            value: 1677,
            color: 'ffbee8',
            description: 'Inter-Mountain Basins Big Sagebrush Shrubland',
          },
          {
            value: 1678,
            color: '894465',
            description: 'Rocky Mountain Lower Montane-Foothill Shrubland',
          },
          {
            value: 1679,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1680,
            color: 'ff73df',
            description: 'Inter-Mountain Basins Big Sagebrush Steppe',
          },
          {
            value: 1681,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 1682,
            color: 'd7ffe8',
            description: 'Northwestern Great Plains Mixedgrass Prairie',
          },
          {
            value: 1683,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1684,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1685,
            color: 'f5f596',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 1686,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1687,
            color: 'bd6a40',
            description: 'Northwestern Great Plains-Black Hills Ponderosa Pine Woodland and Savanna',
          },
          {
            value: 1688,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 1689,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 1690,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 1691,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1692,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1693,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1694,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 1695,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1696,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1697,
            color: '737300',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 1698,
            color: '895a44',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 1699,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1700,
            color: '00874a',
            description: 'Ozark-Ouachita Mesic Hardwood Forest',
          },
          {
            value: 1701,
            color: '614500',
            description: 'Ozark-Ouachita Dry Oak Woodland',
          },
          {
            value: 1702,
            color: 'c4a464',
            description: 'Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland',
          },
          {
            value: 1703,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 1704,
            color: 'd1ff73',
            description: 'Edwards Plateau Limestone Savanna and Woodland',
          },
          {
            value: 1705,
            color: 'ffcb7d',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 1706,
            color: 'ff7f7f',
            description: 'Southern Blackland Tallgrass Prairie',
          },
          {
            value: 1707,
            color: '874b78',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 1708,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1709,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1710,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1711,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1712,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 1713,
            color: 'cf940a',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 1714,
            color: '66ffab',
            description: 'Edwards Plateau Dry-Mesic Slope Forest and Woodland',
          },
          {
            value: 1715,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 1716,
            color: 'ff3884',
            description: 'Apacherian-Chihuahuan Mesquite Upland Scrub',
          },
          {
            value: 1717,
            color: '9c289c',
            description: 'Western Great Plains Mesquite Woodland and Shrubland',
          },
          {
            value: 1718,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 1719,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 1720,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 1721,
            color: '7ba075',
            description: 'North American Warm Desert Riparian Systems',
          },
          {
            value: 1722,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 1723,
            color: '895a44',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 1724,
            color: 'c25e00',
            description: 'East-Central Texas Plains Southern Pine Forest and Woodland',
          },
          {
            value: 1725,
            color: 'd1ff73',
            description: 'Edwards Plateau Limestone Savanna and Woodland',
          },
          {
            value: 1726,
            color: 'd79ca0',
            description: 'Tamaulipan Mixed Deciduous Thornscrub',
          },
          {
            value: 1727,
            color: 'cd6699',
            description: 'Tamaulipan Calcareous Thornscrub',
          },
          {
            value: 1728,
            color: 'ffcb7d',
            description: 'Edwards Plateau Limestone Shrubland',
          },
          {
            value: 1729,
            color: 'c496f5',
            description: 'Llano Uplift Acidic Forest-Woodland-Glade',
          },
          {
            value: 1730,
            color: 'ff7f7f',
            description: 'Southern Blackland Tallgrass Prairie',
          },
          {
            value: 1731,
            color: '874b78',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 1732,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1733,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1734,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1735,
            color: 'a6b382',
            description: 'Chihuahuan-Sonoran Desert Bottomland and Swale Grassland',
          },
          {
            value: 1736,
            color: 'cf940a',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 1737,
            color: '66ffab',
            description: 'Edwards Plateau Dry-Mesic Slope Forest and Woodland',
          },
          {
            value: 1738,
            color: 'ffa8e8',
            description: 'Edwards Plateau Mesic Canyon',
          },
          {
            value: 1739,
            color: '7aa3f5',
            description: 'Edwards Plateau Riparian',
          },
          {
            value: 1740,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1741,
            color: 'a5f57a',
            description: 'Central and South Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 1742,
            color: 'db45df',
            description: 'West Gulf Coastal Plain Chenier and Upper Texas Coastal Fringe Forest and Woodland',
          },
          {
            value: 1743,
            color: 'c25e00',
            description: 'East-Central Texas Plains Southern Pine Forest and Woodland',
          },
          {
            value: 1744,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 1745,
            color: 'd1ff73',
            description: 'Edwards Plateau Limestone Savanna and Woodland',
          },
          {
            value: 1746,
            color: 'd79ca0',
            description: 'Tamaulipan Mixed Deciduous Thornscrub',
          },
          {
            value: 1747,
            color: 'cd6699',
            description: 'Tamaulipan Calcareous Thornscrub',
          },
          {
            value: 1748,
            color: 'ff7f7f',
            description: 'Southern Blackland Tallgrass Prairie',
          },
          {
            value: 1749,
            color: 'dba3df',
            description: 'Texas-Louisiana Coastal Prairie',
          },
          {
            value: 1750,
            color: '8400cf',
            description: 'Central and Upper Texas Coast Dune and Coastal Grassland',
          },
          {
            value: 1751,
            color: 'c7d769',
            description: 'Tamaulipan Savanna Grassland',
          },
          {
            value: 1752,
            color: '872600',
            description: 'South Texas Lomas',
          },
          {
            value: 1753,
            color: 'eb5700',
            description: 'Tamaulipan Clay Grassland',
          },
          {
            value: 1754,
            color: 'ffedcf',
            description: 'South Texas Sand Sheet Grassland',
          },
          {
            value: 1755,
            color: '66b5cd',
            description: 'Tamaulipan Floodplain',
          },
          {
            value: 1756,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1757,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1758,
            color: 'abd6eb',
            description: 'Tamaulipan Riparian Systems',
          },
          {
            value: 1759,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1760,
            color: 'f5b92f',
            description: 'Texas-Louisiana Saline Coastal Prairie',
          },
          {
            value: 1761,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1762,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 1763,
            color: 'cf940a',
            description: 'East-Central Texas Plains Post Oak Savanna and Woodland',
          },
          {
            value: 1764,
            color: 'decd95',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest',
          },
          {
            value: 1765,
            color: 'a87c23',
            description: 'East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest',
          },
          {
            value: 1766,
            color: 'e8a1d4',
            description: 'East Gulf Coastal Plain Northern Loess Bluff Forest',
          },
          {
            value: 1767,
            color: 'c3ff4a',
            description: 'East Gulf Coastal Plain Limestone Forest',
          },
          {
            value: 1768,
            color: 'a80836',
            description: 'East Gulf Coastal Plain Southern Loess Bluff Forest',
          },
          {
            value: 1769,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 1770,
            color: '98b000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 1771,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1772,
            color: 'bf9747',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 1773,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1774,
            color: 'df61ff',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest',
          },
          {
            value: 1775,
            color: 'ff8e6b',
            description: 'Southern Coastal Plain Blackland Prairie and Woodland',
          },
          {
            value: 1776,
            color: '4d219c',
            description: 'East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods',
          },
          {
            value: 1777,
            color: 'bee8ff',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 1778,
            color: '444f91',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 1779,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1780,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1781,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1782,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1783,
            color: 'c3ff4a',
            description: 'East Gulf Coastal Plain Limestone Forest',
          },
          {
            value: 1784,
            color: 'a80836',
            description: 'East Gulf Coastal Plain Southern Loess Bluff Forest',
          },
          {
            value: 1785,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 1786,
            color: '98b000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 1787,
            color: '4cba0a',
            description: 'Florida Longleaf Pine Sandhill',
          },
          {
            value: 1788,
            color: 'bf9747',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 1789,
            color: 'df61ff',
            description: 'East Gulf Coastal Plain Interior Shortleaf Pine-Oak Forest',
          },
          {
            value: 1790,
            color: 'd682ff',
            description: 'East Gulf Coastal Plain Maritime Forest',
          },
          {
            value: 1791,
            color: '8436de',
            description: 'East Gulf Coastal Plain Dune and Coastal Grassland',
          },
          {
            value: 1792,
            color: '95e376',
            description: 'East Gulf Coastal Plain Near-Coast Pine Flatwoods',
          },
          {
            value: 1793,
            color: '4d219c',
            description: 'East Gulf Coastal Plain Southern Loblolly-Hardwood Flatwoods',
          },
          {
            value: 1794,
            color: 'a80a00',
            description: 'Southern Coastal Plain Nonriverine Cypress Dome',
          },
          {
            value: 1795,
            color: 'bee8ff',
            description: 'Southern Coastal Plain Seepage Swamp and Baygall',
          },
          {
            value: 1796,
            color: '444f91',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 1797,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1798,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1799,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1800,
            color: 'ffd978',
            description: 'East Gulf Coastal Plain Savanna and Wet Prairie',
          },
          {
            value: 1801,
            color: 'f0ff5e',
            description: 'Floridian Highlands Freshwater Marsh',
          },
          {
            value: 1802,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1803,
            color: 'ab6138',
            description: 'Gulf and Atlantic Coastal Plain Sparsely Vegetated Systems',
          },
          {
            value: 1804,
            color: 'b5e3c2',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 1805,
            color: '63c77d',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 1806,
            color: '8ab1ff',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 1807,
            color: 'ed5e36',
            description: 'Piedmont Hardpan Woodland and Forest',
          },
          {
            value: 1808,
            color: '8fa11a',
            description: 'Southeastern Interior Longleaf Pine Woodland',
          },
          {
            value: 1809,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 1810,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1811,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1812,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1813,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1814,
            color: 'a39c2e',
            description: 'Southern Appalachian Northern Hardwood Forest',
          },
          {
            value: 1815,
            color: 'b5e3c2',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 1816,
            color: '63c77d',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 1817,
            color: 'bab894',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 1818,
            color: '8ab1ff',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 1819,
            color: 'b482b4',
            description: 'Central and Southern Appalachian Montane Oak Forest',
          },
          {
            value: 1820,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 1821,
            color: 'cfd633',
            description: 'Central and Southern Appalachian Spruce-Fir Forest',
          },
          {
            value: 1822,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 1823,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1824,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1825,
            color: 'de997a',
            description: 'Southern Ridge and Valley/Cumberland Dry Calcareous Forest',
          },
          {
            value: 1826,
            color: 'f00a0a',
            description: 'Southern Appalachian Grass and Shrub Bald',
          },
          {
            value: 1827,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1828,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1829,
            color: '63c77d',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 1830,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 1831,
            color: 'a87000',
            description: 'Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1832,
            color: '4e9c1a',
            description: 'Atlantic Coastal Plain Fall-line Sandhills Longleaf Pine Woodland',
          },
          {
            value: 1833,
            color: '98b000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 1834,
            color: '8fa11a',
            description: 'Southeastern Interior Longleaf Pine Woodland',
          },
          {
            value: 1835,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 1836,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1837,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1838,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1839,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1840,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1841,
            color: '63c77d',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 1842,
            color: 'a1705a',
            description: 'Northern Atlantic Coastal Plain Hardwood Forest',
          },
          {
            value: 1843,
            color: 'e6cd9c',
            description: 'Atlantic Coastal Plain Dry and Dry-Mesic Oak Forest',
          },
          {
            value: 1844,
            color: 'a87000',
            description: 'Atlantic Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 1845,
            color: '87ba18',
            description: 'Atlantic Coastal Plain Upland Longleaf Pine Woodland',
          },
          {
            value: 1846,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 1847,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1848,
            color: 'ffa552',
            description: 'Northern Atlantic Coastal Plain Pitch Pine Barrens',
          },
          {
            value: 1849,
            color: 'ed00e5',
            description: 'Central Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1850,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1851,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1852,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1853,
            color: 'e55e63',
            description: 'Eastern Serpentine Woodland',
          },
          {
            value: 1854,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1855,
            color: 'ed00b3',
            description: 'Northern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1856,
            color: 'ff99e5',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 1857,
            color: '641f57',
            description: 'Northern Atlantic Coastal Plain Dune and Swale',
          },
          {
            value: 1858,
            color: '8fed29',
            description: 'Central Atlantic Coastal Plain Wet Longleaf Pine Savanna and Flatwoods',
          },
          {
            value: 1859,
            color: 'ff7d00',
            description: 'Atlantic Coastal Plain Peatland Pocosin and Canebrake',
          },
          {
            value: 1860,
            color: '444f91',
            description: 'Atlantic Coastal Plain Streamhead Seepage Swamp-Pocosin-Baygall',
          },
          {
            value: 1861,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1862,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1863,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 1864,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 1865,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1866,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1867,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1868,
            color: 'ab6138',
            description: 'Gulf and Atlantic Coastal Plain Sparsely Vegetated Systems',
          },
          {
            value: 1869,
            color: '63d6ff',
            description: 'Central Atlantic Coastal Plain Nonriverine Swamp and Wet Hardwood Forest',
          },
          {
            value: 1870,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1871,
            color: 'b5e3c2',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 1872,
            color: '63c77d',
            description: 'Southern Piedmont Mesic Forest',
          },
          {
            value: 1873,
            color: 'bab894',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 1874,
            color: '8ab1ff',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 1875,
            color: 'b482b4',
            description: 'Central and Southern Appalachian Montane Oak Forest',
          },
          {
            value: 1876,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 1877,
            color: '9c9c9c',
            description: 'Appalachian Shale Barrens',
          },
          {
            value: 1878,
            color: '902bb5',
            description: 'Central and Southern Appalachian Spruce-Fir Forest',
          },
          {
            value: 1879,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 1880,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 1881,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 1882,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1883,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1884,
            color: 'de997a',
            description: 'Southern Ridge and Valley/Cumberland Dry Calcareous Forest',
          },
          {
            value: 1885,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1886,
            color: 'ff99e5',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 1887,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1888,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1889,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1890,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1891,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1892,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 1893,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1894,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1895,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1896,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1897,
            color: '82a064',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 1898,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1899,
            color: 'ff99e5',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 1900,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1901,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1902,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1903,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1904,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1905,
            color: 'e8bdff',
            description: 'Laurentian-Acadian Alkaline Conifer-Hardwood Swamp',
          },
          {
            value: 1906,
            color: '7af5ca',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 1907,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1908,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 1909,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1910,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1911,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 1912,
            color: 'bab894',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 1913,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 1914,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1915,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1916,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1917,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1918,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1919,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 1920,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1921,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1922,
            color: 'a1705a',
            description: 'Northern Atlantic Coastal Plain Hardwood Forest',
          },
          {
            value: 1923,
            color: 'ffa552',
            description: 'Northern Atlantic Coastal Plain Pitch Pine Barrens',
          },
          {
            value: 1924,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1925,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1926,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1927,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1928,
            color: '82a064',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 1929,
            color: '906bb5',
            description: 'Acadian-Appalachian Montane Spruce-Fir Forest',
          },
          {
            value: 1930,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1931,
            color: 'ed00b3',
            description: 'Northern Atlantic Coastal Plain Maritime Forest',
          },
          {
            value: 1932,
            color: '641f57',
            description: 'Northern Atlantic Coastal Plain Dune and Swale',
          },
          {
            value: 1933,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1934,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1935,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1936,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1937,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1938,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1939,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1940,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1941,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 1942,
            color: 'e8a0ff',
            description: 'Laurentian-Acadian Swamp Systems',
          },
          {
            value: 1943,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1944,
            color: 'd7b964',
            description: 'Northeastern Interior Dry-Mesic Oak Forest',
          },
          {
            value: 1945,
            color: 'ffc452',
            description: 'Northeastern Interior Pine Barrens',
          },
          {
            value: 1946,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1947,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1948,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1949,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1950,
            color: '82a064',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 1951,
            color: '906bb5',
            description: 'Acadian-Appalachian Montane Spruce-Fir Forest',
          },
          {
            value: 1952,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1953,
            color: '96ffe7',
            description: 'Acadian-Appalachian Subalpine Woodland and Heath-Krummholz',
          },
          {
            value: 1954,
            color: 'ff99e5',
            description: 'Central Appalachian Alkaline Glade and Woodland',
          },
          {
            value: 1955,
            color: 'e3eb75',
            description: 'Great Lakes Alvar',
          },
          {
            value: 1956,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1957,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1958,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1959,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1960,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1961,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1962,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1963,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 1964,
            color: 'e8a0ff',
            description: 'Laurentian-Acadian Swamp Systems',
          },
          {
            value: 1965,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 1966,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 1967,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 1968,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 1969,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 1970,
            color: 'ebff00',
            description: 'Great Lakes Wet-Mesic Lakeplain Prairie',
          },
          {
            value: 1971,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 1972,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 1973,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 1974,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1975,
            color: '7af5ca',
            description: 'Great Lakes Coastal Marsh Systems',
          },
          {
            value: 1976,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1977,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 1978,
            color: '4ce600',
            description: 'Laurentian-Acadian Northern Hardwoods Forest',
          },
          {
            value: 1979,
            color: 'a1705a',
            description: 'Northern Atlantic Coastal Plain Hardwood Forest',
          },
          {
            value: 1980,
            color: 'ff8c8c',
            description: 'Boreal Jack Pine-Black Spruce Forest',
          },
          {
            value: 1981,
            color: 'ffc452',
            description: 'Northeastern Interior Pine Barrens',
          },
          {
            value: 1982,
            color: 'ffbfbf',
            description: 'Laurentian-Acadian Northern Pine(-Oak) Forest',
          },
          {
            value: 1983,
            color: 'd0ff63',
            description: 'Laurentian-Acadian Pine-Hemlock-Hardwood Forest',
          },
          {
            value: 1984,
            color: '00ffdc',
            description: 'Central Appalachian Dry Oak-Pine Forest',
          },
          {
            value: 1985,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 1986,
            color: '82a064',
            description: 'Acadian Low-Elevation Spruce-Fir-Hardwood Forest',
          },
          {
            value: 1987,
            color: '906bb5',
            description: 'Acadian-Appalachian Montane Spruce-Fir Forest',
          },
          {
            value: 1988,
            color: 'ff004d',
            description: 'Central Appalachian Pine-Oak Rocky Woodland',
          },
          {
            value: 1989,
            color: 'c8037d',
            description: 'Acadian-Appalachian Alpine Tundra',
          },
          {
            value: 1990,
            color: '96ffe7',
            description: 'Acadian-Appalachian Subalpine Woodland and Heath-Krummholz',
          },
          {
            value: 1991,
            color: '641f57',
            description: 'Northern Atlantic Coastal Plain Dune and Swale',
          },
          {
            value: 1992,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 1993,
            color: '7a8ff5',
            description: 'Laurentian-Acadian Floodplain Systems',
          },
          {
            value: 1994,
            color: '6a008a',
            description: 'Boreal Acidic Peatland Systems',
          },
          {
            value: 1995,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 1996,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 1997,
            color: 'ffeb00',
            description: 'Gulf and Atlantic Coastal Plain Tidal Marsh Systems',
          },
          {
            value: 1998,
            color: '00a86b',
            description: 'Laurentian-Acadian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 1999,
            color: 'e8a0ff',
            description: 'Laurentian-Acadian Swamp Systems',
          },
          {
            value: 2000,
            color: 'b89c21',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 2001,
            color: 'a39c2e',
            description: 'Southern Appalachian Northern Hardwood Forest',
          },
          {
            value: 2002,
            color: 'b5e3c2',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 2003,
            color: 'bab894',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 2004,
            color: '8ab1ff',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 2005,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 2006,
            color: '7547c5',
            description: 'Southern Appalachian Montane Pine Forest and Woodland',
          },
          {
            value: 2007,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 2008,
            color: 'e52600',
            description: 'Central Interior Highlands Dry Acidic Glade and Barrens',
          },
          {
            value: 2009,
            color: 'd6ff91',
            description: 'Appalachian (Hemlock-)Northern Hardwood Forest',
          },
          {
            value: 2010,
            color: 'de997a',
            description: 'Southern Ridge and Valley/Cumberland Dry Calcareous Forest',
          },
          {
            value: 2011,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2012,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2013,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 2014,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 2015,
            color: '737300',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 2016,
            color: 'b89c21',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 2017,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2018,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 2019,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 2020,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 2021,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 2022,
            color: '9ced26',
            description: 'South-Central Interior/Upper Coastal Plain Flatwoods',
          },
          {
            value: 2023,
            color: '614500',
            description: 'Ozark-Ouachita Dry Oak Woodland',
          },
          {
            value: 2024,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 2025,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 2026,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2027,
            color: 'ebff00',
            description: 'Great Lakes Wet-Mesic Lakeplain Prairie',
          },
          {
            value: 2028,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 2029,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 2030,
            color: 'baed26',
            description: 'South-Central Interior/Upper Coastal Plain Wet Flatwoods',
          },
          {
            value: 2031,
            color: 'b50000',
            description: 'Great Lakes Wooded Dune and Swale',
          },
          {
            value: 2032,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 2033,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2034,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 2035,
            color: '6a7500',
            description: 'Paleozoic Plateau Bluff and Talus',
          },
          {
            value: 2036,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 2037,
            color: '737300',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 2038,
            color: '895a44',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 2039,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2040,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 2041,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 2042,
            color: '00874a',
            description: 'Ozark-Ouachita Mesic Hardwood Forest',
          },
          {
            value: 2043,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 2044,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2045,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 2046,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 2047,
            color: '874b78',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 2048,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 2049,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2050,
            color: '941433',
            description: 'Eastern Great Plains Wet Meadow-Prairie-Marsh',
          },
          {
            value: 2051,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 2052,
            color: 'dc0000',
            description: 'Western Great Plains Dry Bur Oak Forest and Woodland',
          },
          {
            value: 2053,
            color: 'a900e6',
            description: 'Western Great Plains Sandhill Steppe',
          },
          {
            value: 2054,
            color: '70a870',
            description: 'Central Mixedgrass Prairie',
          },
          {
            value: 2055,
            color: 'f5daa9',
            description: 'Western Great Plains Sand Prairie',
          },
          {
            value: 2056,
            color: 'cdcd66',
            description: 'Western Great Plains Shortgrass Prairie',
          },
          {
            value: 2057,
            color: 'f5f596',
            description: 'Western Great Plains Tallgrass Prairie',
          },
          {
            value: 2058,
            color: '6699cd',
            description: 'Western Great Plains Floodplain Systems',
          },
          {
            value: 2059,
            color: '895a44',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 2060,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2061,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 2062,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 2063,
            color: '874b78',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 2064,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 2065,
            color: '941433',
            description: 'Eastern Great Plains Wet Meadow-Prairie-Marsh',
          },
          {
            value: 2066,
            color: '68009c',
            description: 'Western Great Plains Depressional Wetland Systems',
          },
          {
            value: 2067,
            color: 'b89c21',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 2068,
            color: 'd994ab',
            description: 'East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland',
          },
          {
            value: 2069,
            color: 'decd95',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest',
          },
          {
            value: 2070,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2071,
            color: '009c2c',
            description: 'North-Central Interior Beech-Maple Forest',
          },
          {
            value: 2072,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 2073,
            color: 'a87c23',
            description: 'East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest',
          },
          {
            value: 2074,
            color: '9ced26',
            description: 'South-Central Interior/Upper Coastal Plain Flatwoods',
          },
          {
            value: 2075,
            color: 'e8a1d4',
            description: 'East Gulf Coastal Plain Northern Loess Bluff Forest',
          },
          {
            value: 2076,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 2077,
            color: 'bf9747',
            description: 'Southern Coastal Plain Mesic Slope Forest',
          },
          {
            value: 2078,
            color: 'e52600',
            description: 'Central Interior Highlands Dry Acidic Glade and Barrens',
          },
          {
            value: 2079,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2080,
            color: 'c7e394',
            description: 'Bluegrass Savanna and Woodland',
          },
          {
            value: 2081,
            color: 'e8e38a',
            description: 'Pennyroyal Karst Plain Prairie and Barrens',
          },
          {
            value: 2082,
            color: 'fcf5ab',
            description: 'East Gulf Coastal Plain Jackson Plain Prairie and Barrens',
          },
          {
            value: 2083,
            color: 'baed26',
            description: 'South-Central Interior/Upper Coastal Plain Wet Flatwoods',
          },
          {
            value: 2084,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2085,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 2086,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 2087,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 2088,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 2089,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 2090,
            color: '006b52',
            description: 'Mississippi River Alluvial Plain Dry-Mesic Loess Slope Forest',
          },
          {
            value: 2091,
            color: 'd3ed26',
            description: 'North-Central Interior Wet Flatwoods',
          },
          {
            value: 2092,
            color: 'b89c21',
            description: 'Southern Interior Low Plateau Dry-Mesic Oak Forest',
          },
          {
            value: 2093,
            color: 'd994ab',
            description: 'East Gulf Coastal Plain Northern Loess Plain Oak-Hickory Upland',
          },
          {
            value: 2094,
            color: 'decd95',
            description: 'East Gulf Coastal Plain Northern Dry Upland Hardwood Forest',
          },
          {
            value: 2095,
            color: 'b5e3c2',
            description: 'Southern Appalachian Oak Forest',
          },
          {
            value: 2096,
            color: 'bab894',
            description: 'Allegheny-Cumberland Dry Oak Forest and Woodland',
          },
          {
            value: 2097,
            color: '8ab1ff',
            description: 'Southern and Central Appalachian Cove Forest',
          },
          {
            value: 2098,
            color: 'b482b4',
            description: 'Central and Southern Appalachian Montane Oak Forest',
          },
          {
            value: 2099,
            color: '478794',
            description: 'South-Central Interior Mesophytic Forest',
          },
          {
            value: 2100,
            color: 'a87c23',
            description: 'East Gulf Coastal Plain Northern Mesic Hardwood Slope Forest',
          },
          {
            value: 2101,
            color: 'f5e7ba',
            description: 'Southern Coastal Plain Dry Upland Hardwood Forest',
          },
          {
            value: 2102,
            color: '98b000',
            description: 'East Gulf Coastal Plain Interior Upland Longleaf Pine Woodland',
          },
          {
            value: 2103,
            color: '8fa11a',
            description: 'Southeastern Interior Longleaf Pine Woodland',
          },
          {
            value: 2104,
            color: 'ffc861',
            description: 'Southern Appalachian Low-Elevation Pine Forest',
          },
          {
            value: 2105,
            color: 'd3baff',
            description: 'Southern Piedmont Dry Oak(-Pine) Forest',
          },
          {
            value: 2106,
            color: 'de997a',
            description: 'Southern Ridge and Valley/Cumberland Dry Calcareous Forest',
          },
          {
            value: 2107,
            color: 'f2f252',
            description: 'Nashville Basin Limestone Glade and Woodland',
          },
          {
            value: 2108,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2109,
            color: 'f2f529',
            description: 'Alabama Ketona Glade and Woodland',
          },
          {
            value: 2110,
            color: 'f2eda8',
            description: 'Western Highland Rim Prairie and Barrens',
          },
          {
            value: 2111,
            color: 'fcfcba',
            description: 'Eastern Highland Rim Prairie and Barrens',
          },
          {
            value: 2112,
            color: 'baed26',
            description: 'South-Central Interior/Upper Coastal Plain Wet Flatwoods',
          },
          {
            value: 2113,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2114,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 2115,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 2116,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 2117,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2118,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 2119,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 2120,
            color: 'a8a800',
            description: 'Western Great Plains Wooded Draw and Ravine',
          },
          {
            value: 2121,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 2122,
            color: 'ffebb0',
            description: 'North-Central Oak Barrens',
          },
          {
            value: 2123,
            color: 'd6009d',
            description: 'North-Central Interior Sand and Gravel Tallgrass Prairie',
          },
          {
            value: 2124,
            color: 'b8841d',
            description: 'Northern Tallgrass Prairie',
          },
          {
            value: 2125,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 2126,
            color: '4baabe',
            description: 'Eastern Great Plains Floodplain Systems',
          },
          {
            value: 2127,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2128,
            color: 'cf3dff',
            description: 'Central Interior and Appalachian Swamp Systems',
          },
          {
            value: 2129,
            color: '941433',
            description: 'Eastern Great Plains Wet Meadow-Prairie-Marsh',
          },
          {
            value: 2130,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 2131,
            color: '6a7500',
            description: 'Paleozoic Plateau Bluff and Talus',
          },
          {
            value: 2132,
            color: '737300',
            description: 'Ozark-Ouachita Dry-Mesic Oak Forest',
          },
          {
            value: 2133,
            color: '895a44',
            description: 'Crosstimbers Oak Forest and Woodland',
          },
          {
            value: 2134,
            color: 'b0a3de',
            description: 'North-Central Interior Dry-Mesic Oak Forest and Woodland',
          },
          {
            value: 2135,
            color: 'b3cf8f',
            description: 'North-Central Interior Dry Oak Forest and Woodland',
          },
          {
            value: 2136,
            color: '002673',
            description: 'Ouachita Montane Oak Forest',
          },
          {
            value: 2137,
            color: 'eda166',
            description: 'North-Central Interior Maple-Basswood Forest',
          },
          {
            value: 2138,
            color: 'b59e8f',
            description: 'West Gulf Coastal Plain Mesic Hardwood Forest',
          },
          {
            value: 2139,
            color: '00874a',
            description: 'Ozark-Ouachita Mesic Hardwood Forest',
          },
          {
            value: 2140,
            color: '614500',
            description: 'Ozark-Ouachita Dry Oak Woodland',
          },
          {
            value: 2141,
            color: 'c4a464',
            description: 'Ozark-Ouachita Shortleaf Pine-Oak Forest and Woodland',
          },
          {
            value: 2142,
            color: '64a800',
            description: 'West Gulf Coastal Plain Pine-Hardwood Forest',
          },
          {
            value: 2143,
            color: 'd1d900',
            description: 'West Gulf Coastal Plain Sandhill Oak and Shortleaf Pine Forest and Woodland',
          },
          {
            value: 2144,
            color: 'e6d58a',
            description: 'North-Central Interior Oak Savanna',
          },
          {
            value: 2145,
            color: 'ffeb14',
            description: 'Central Interior Highlands Calcareous Glade and Barrens',
          },
          {
            value: 2146,
            color: 'ff78bb',
            description: 'Arkansas Valley Prairie and Woodland - Prairie',
          },
          {
            value: 2147,
            color: 'cc8ab3',
            description: 'Arkansas Valley Prairie and Woodland - Woodland',
          },
          {
            value: 2148,
            color: 'e8ffc4',
            description: 'Central Tallgrass Prairie',
          },
          {
            value: 2149,
            color: '874b78',
            description: 'Southeastern Great Plains Tallgrass Prairie',
          },
          {
            value: 2150,
            color: 'ff006e',
            description: 'West Gulf Coastal Plain Northern Calcareous Prairie',
          },
          {
            value: 2151,
            color: '63eb61',
            description: 'West Gulf Coastal Plain Pine-Hardwood Flatwoods',
          },
          {
            value: 2152,
            color: '00bfb0',
            description: 'Central Interior and Appalachian Floodplain Systems',
          },
          {
            value: 2153,
            color: '30ed38',
            description: 'South-Central Interior Large Floodplain',
          },
          {
            value: 2154,
            color: '24ff14',
            description: 'Central Interior and Appalachian Riparian Systems',
          },
          {
            value: 2155,
            color: '6677cd',
            description: 'Gulf and Atlantic Coastal Plain Floodplain Systems',
          },
          {
            value: 2156,
            color: 'abb9eb',
            description: 'Gulf and Atlantic Coastal Plain Small Stream Riparian Systems',
          },
          {
            value: 2157,
            color: '66d4b3',
            description: 'Gulf and Atlantic Coastal Plain Swamp Systems',
          },
          {
            value: 2158,
            color: 'f09614',
            description: 'Central Interior and Appalachian Shrub-Herbaceous Wetland Systems',
          },
          {
            value: 2159,
            color: '267300',
            description: 'West Gulf Coastal Plain Nonriverine Wet Hardwood Flatwoods',
          },
          {
            value: 2160,
            color: '448970',
            description: 'Ozark-Ouachita Shortleaf Pine-Bluestem Woodland',
          },
          {
            value: 2161,
            color: 'af381c',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 2162,
            color: 'ccaf93',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 2163,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Infrequent Fire',
          },
          {
            value: 2164,
            color: 'bfbfbf',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 2165,
            color: 'f9efe5',
            description: 'Alaska Arctic Mesic Sedge-Dryas Tundra',
          },
          {
            value: 2166,
            color: 'e5e5f9',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 2167,
            color: 'f2f2f2',
            description: 'Alaska Arctic Non-Acidic Sparse Tundra',
          },
          {
            value: 2168,
            color: 'c1b7e8',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 2169,
            color: 'edd8ad',
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2170,
            color: 'ffe2c1',
            description: 'Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2171,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Infrequent Fire',
          },
          {
            value: 2172,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Infrequent Fire',
          },
          {
            value: 2173,
            color: '00cccc',
            description: 'Alaska Arctic Pendantgrass Freshwater Marsh',
          },
          {
            value: 2174,
            color: 'c1ffc1',
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 2175,
            color: 'eded00',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 2176,
            color: 'ff8247',
            description: 'Alaska Arctic Coastal Sedge-Dwarf-Shrubland',
          },
          {
            value: 2177,
            color: 'e0eded',
            description: 'Alaska Arctic Wet Sedge-Sphagnum Peatland',
          },
          {
            value: 2178,
            color: 'c1cccc',
            description: 'Alaska Arctic Dwarf-Shrub-Sphagnum Peatland',
          },
          {
            value: 2179,
            color: '00bfff',
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 2180,
            color: 'afe2ff',
            description: 'Alaska Arctic Polygonal Ground Wet Sedge Tundra',
          },
          {
            value: 2181,
            color: 'e2ffe2',
            description: 'Alaska Arctic Polygonal Ground Shrub-Tussock Tundra',
          },
          {
            value: 2182,
            color: 'fff28e',
            description: 'Alaska Arctic Marine Beach and Beach Meadow',
          },
          {
            value: 2183,
            color: 'ede0e5',
            description: 'Alaska Arctic Tidal Marsh',
          },
          {
            value: 2184,
            color: '63b7ff',
            description: 'Alaska Arctic Coastal Brackish Meadow',
          },
          {
            value: 2185,
            color: '0f4f8c',
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 2186,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2187,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2188,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2189,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2190,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2191,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2192,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2193,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2194,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2195,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2196,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2197,
            color: 'af381c',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 2198,
            color: 'ccaf93',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 2199,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Infrequent Fire',
          },
          {
            value: 2200,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Frequent Fire',
          },
          {
            value: 2201,
            color: 'bfbfbf',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 2202,
            color: 'f9efe5',
            description: 'Alaska Arctic Mesic Sedge-Dryas Tundra',
          },
          {
            value: 2203,
            color: 'e5e5f9',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 2204,
            color: 'f2f2d8',
            description: 'Alaska Arctic Non-Acidic Sparse Tundra',
          },
          {
            value: 2205,
            color: 'c1b7e8',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 2206,
            color: 'edd8ad',
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2207,
            color: 'ffe2c1',
            description: 'Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2208,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Frequent Fire',
          },
          {
            value: 2209,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Infrequent Fire',
          },
          {
            value: 2210,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Frequent Fire',
          },
          {
            value: 2211,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Infrequent Fire',
          },
          {
            value: 2212,
            color: '00cccc',
            description: 'Alaska Arctic Pendantgrass Freshwater Marsh',
          },
          {
            value: 2213,
            color: 'c1ffc1',
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 2214,
            color: 'eded00',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 2215,
            color: 'ff8247',
            description: 'Alaska Arctic Coastal Sedge-Dwarf-Shrubland',
          },
          {
            value: 2216,
            color: 'e0eded',
            description: 'Alaska Arctic Wet Sedge-Sphagnum Peatland',
          },
          {
            value: 2217,
            color: 'c1cccc',
            description: 'Alaska Arctic Dwarf-Shrub-Sphagnum Peatland',
          },
          {
            value: 2218,
            color: 'e0ede0',
            description: 'Alaska Arctic Permafrost Plateau Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 2219,
            color: '00bfff',
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 2220,
            color: 'afe2ff',
            description: 'Alaska Arctic Polygonal Ground Wet Sedge Tundra',
          },
          {
            value: 2221,
            color: 'e2ffe2',
            description: 'Alaska Arctic Polygonal Ground Shrub-Tussock Tundra',
          },
          {
            value: 2222,
            color: 'ede0e5',
            description: 'Alaska Arctic Tidal Marsh',
          },
          {
            value: 2223,
            color: '63b7ff',
            description: 'Alaska Arctic Coastal Brackish Meadow',
          },
          {
            value: 2224,
            color: 'e58c4c',
            description: 'Alaska Arctic Active Inland Dune',
          },
          {
            value: 2225,
            color: '1c87ed',
            description: 'Alaska Arctic Large River Floodplain',
          },
          {
            value: 2226,
            color: '0f4f8c',
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 2227,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2228,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2229,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2230,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2231,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Higher Elevations',
          },
          {
            value: 2232,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2233,
            color: 'ba6b59',
            description: 'Alaska Sub-boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2234,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2235,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2236,
            color: 'ffff00',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 2237,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2238,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2239,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2240,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2241,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2242,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2243,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2244,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2245,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2246,
            color: 'efe58c',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2247,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2248,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2249,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2250,
            color: 'af381c',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 2251,
            color: 'ccaf93',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 2252,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Frequent Fire',
          },
          {
            value: 2253,
            color: 'bfbfbf',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 2254,
            color: 'f9efe5',
            description: 'Alaska Arctic Mesic Sedge-Dryas Tundra',
          },
          {
            value: 2255,
            color: 'e5e5f9',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 2256,
            color: 'f2f2d8',
            description: 'Alaska Arctic Non-Acidic Sparse Tundra',
          },
          {
            value: 2257,
            color: 'c1b7e8',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 2258,
            color: 'edd8ad',
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2259,
            color: 'ffe2c1',
            description: 'Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2260,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Frequent Fire',
          },
          {
            value: 2261,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Frequent Fire',
          },
          {
            value: 2262,
            color: '00cccc',
            description: 'Alaska Arctic Pendantgrass Freshwater Marsh',
          },
          {
            value: 2263,
            color: 'c1ffc1',
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 2264,
            color: 'eded00',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 2265,
            color: '00bfff',
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 2266,
            color: 'afe2ff',
            description: 'Alaska Arctic Polygonal Ground Wet Sedge Tundra',
          },
          {
            value: 2267,
            color: 'e2ffe2',
            description: 'Alaska Arctic Polygonal Ground Shrub-Tussock Tundra',
          },
          {
            value: 2268,
            color: '0f4f8c',
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 2269,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2270,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2271,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2272,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2273,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Lower Elevations',
          },
          {
            value: 2274,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Higher Elevations',
          },
          {
            value: 2275,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2276,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2277,
            color: 'ba6b59',
            description: 'Alaska Sub-Boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2278,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2279,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2280,
            color: 'ffff00',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 2281,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2282,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2283,
            color: '6bf2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2284,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2285,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2286,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2287,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2288,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2289,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2290,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2291,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2293,
            color: 'efe58c',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2294,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2295,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2296,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2297,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2298,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2299,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2300,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Lower Elevations',
          },
          {
            value: 2301,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Higher Elevations',
          },
          {
            value: 2302,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2303,
            color: 'ba6b59',
            description: 'Alaska Sub-Boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2304,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2305,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2306,
            color: 'f2a360',
            description: 'Western North American Boreal Active Inland Dune',
          },
          {
            value: 2307,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2308,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2309,
            color: '6bf2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2310,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2311,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2312,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2313,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2314,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2315,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2316,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2317,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2318,
            color: 'efe58c',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2319,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2320,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2321,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2322,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2323,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2324,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2325,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2326,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2327,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2328,
            color: 'ba6d5b',
            description: 'Alaska Sub-boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2329,
            color: 'a52828',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2330,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2331,
            color: '7fffd3',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2332,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2333,
            color: '6df2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2334,
            color: '63f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2335,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2336,
            color: 'a021ef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2337,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2338,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2339,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2340,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2341,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2342,
            color: 'af381c',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 2343,
            color: 'ccaf93',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 2344,
            color: 'fff9cc',
            description: 'Alaskan Pacific Maritime Mesic Herbaceous Meadow',
          },
          {
            value: 2345,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Frequent Fire',
          },
          {
            value: 2346,
            color: 'bfbfbf',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 2347,
            color: 'e5e5f9',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 2348,
            color: 'c1b7e8',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 2349,
            color: 'edd8ad',
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 2350,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Frequent Fire',
          },
          {
            value: 2351,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Frequent Fire',
          },
          {
            value: 2352,
            color: '00cccc',
            description: 'Alaska Arctic Pendantgrass Freshwater Marsh',
          },
          {
            value: 2353,
            color: 'c1ffc1',
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 2354,
            color: 'eded00',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 2355,
            color: 'ff8247',
            description: 'Alaska Arctic Coastal Sedge-Dwarf-Shrubland',
          },
          {
            value: 2356,
            color: 'e0eded',
            description: 'Alaska Arctic Wet Sedge-Sphagnum Peatland',
          },
          {
            value: 2357,
            color: 'c1cccc',
            description: 'Alaska Arctic Dwarf-Shrub-Sphagnum Peatland',
          },
          {
            value: 2358,
            color: 'e0ede0',
            description: 'Alaska Arctic Permafrost Plateau Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 2359,
            color: '00bfff',
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 2360,
            color: 'afe2ff',
            description: 'Alaska Arctic Polygonal Ground Wet Sedge Tundra',
          },
          {
            value: 2361,
            color: 'e2ffe2',
            description: 'Alaska Arctic Polygonal Ground Shrub-Tussock Tundra',
          },
          {
            value: 2362,
            color: 'fff28e',
            description: 'Alaska Arctic Marine Beach and Beach Meadow',
          },
          {
            value: 2363,
            color: 'ede0e5',
            description: 'Alaska Arctic Tidal Marsh',
          },
          {
            value: 2364,
            color: '63b7ff',
            description: 'Alaska Arctic Coastal Brackish Meadow',
          },
          {
            value: 2365,
            color: '1c87ed',
            description: 'Alaska Arctic Large River Floodplain',
          },
          {
            value: 2366,
            color: '0f4f8c',
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 2367,
            color: 'f2f2f2',
            description: 'Alaska Arctic Bedrock and Talus',
          },
          {
            value: 2368,
            color: '4c3833',
            description: 'Aleutian Volcanic Rock and Talus',
          },
          {
            value: 2369,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2370,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Alaska Sub-boreal',
          },
          {
            value: 2371,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2372,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2373,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Alaska Sub-boreal',
          },
          {
            value: 2374,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2375,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Lower Elevations',
          },
          {
            value: 2376,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Higher Elevations',
          },
          {
            value: 2377,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2378,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2379,
            color: 'ba6b59',
            description: 'Alaska Sub-Boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2380,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2381,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2382,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2383,
            color: 'ffff00',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 2384,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2385,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2386,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2387,
            color: '6bf2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2388,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2389,
            color: '59edd1',
            description: 'Western North American Boreal Herbaceous Fen - Alaska Sub-Boreal Complex',
          },
          {
            value: 2390,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2391,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Alaska Sub-boreal Complex',
          },
          {
            value: 2392,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2393,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2394,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2395,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2396,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2397,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2399,
            color: 'efe58c',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2400,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2401,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2402,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2403,
            color: '006300',
            description: 'Aleutian Kenai Birch-Cottonwood-Poplar Forest',
          },
          {
            value: 2404,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 2405,
            color: 'edc600',
            description: 'Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2406,
            color: '00ff00',
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 2407,
            color: '005600',
            description: 'Alaskan Pacific Maritime Western Hemlock Forest',
          },
          {
            value: 2408,
            color: '3f9900',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest - Southeast',
          },
          {
            value: 2409,
            color: '7fff00',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2410,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2411,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Alaska Sub-boreal',
          },
          {
            value: 2412,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2413,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2414,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Alaska Sub-boreal',
          },
          {
            value: 2415,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2416,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Lower Elevations',
          },
          {
            value: 2417,
            color: '00e800',
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff - Higher Elevations',
          },
          {
            value: 2418,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2419,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2420,
            color: 'ba6b59',
            description: 'Alaska Sub-Boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2421,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2422,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2423,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2424,
            color: 'ffff00',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 2425,
            color: 'f2a360',
            description: 'Western North American Boreal Active Inland Dune',
          },
          {
            value: 2426,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Boreal',
          },
          {
            value: 2427,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2428,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2429,
            color: '6bf2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2430,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2431,
            color: '59edd1',
            description: 'Western North American Boreal Herbaceous Fen - Alaska Sub-Boreal Complex',
          },
          {
            value: 2432,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Boreal Complex',
          },
          {
            value: 2433,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Alaska Sub-boreal Complex',
          },
          {
            value: 2434,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2435,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2436,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2437,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2438,
            color: 'd8e5d8',
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 2439,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2441,
            color: 'efe58c',
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2442,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2443,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2444,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2445,
            color: '005600',
            description: 'Alaskan Pacific Maritime Western Hemlock Forest',
          },
          {
            value: 2446,
            color: '7fff00',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2447,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2448,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2449,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Alaska Sub-boreal',
          },
          {
            value: 2450,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2451,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2452,
            color: 'ba6b59',
            description: 'Alaska Sub-Boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 2453,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2454,
            color: 'ffd600',
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 2455,
            color: 'ffff00',
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 2456,
            color: '7fffd1',
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2457,
            color: '6bf2d1',
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 2458,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2459,
            color: '59edd1',
            description: 'Western North American Boreal Herbaceous Fen - Alaska Sub-Boreal Complex',
          },
          {
            value: 2460,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-tree Peatland - Alaska Sub-boreal Complex',
          },
          {
            value: 2461,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2462,
            color: 'ed82ed',
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 2463,
            color: 'efffef',
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 2464,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2465,
            color: 'ccd8cc',
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 2467,
            color: 'f2d1ad',
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland - Complex',
          },
          {
            value: 2468,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2469,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Higher Elevations',
          },
          {
            value: 2470,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 2471,
            color: '3f9900',
            description: 'Alaska Sub-boreal Mountain Hemlock Forest - Northern',
          },
          {
            value: 2472,
            color: '3f9900',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest - Northern',
          },
          {
            value: 2473,
            color: 'b7cc33',
            description: 'Alaskan Pacific Maritime Periglacial Woodland and Shrubland',
          },
          {
            value: 2474,
            color: '7fffd1',
            description: 'Alaskan Pacific Maritime Wet Low Shrubland',
          },
          {
            value: 2476,
            color: 'ed82ed',
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 2477,
            color: 'ffffe0',
            description: 'Alaskan Pacific Maritime Alpine Wet Meadow',
          },
          {
            value: 2478,
            color: 'ffb5bf',
            description: 'Alaskan Pacific Maritime Alpine Floodplain',
          },
          {
            value: 2479,
            color: '3fff00',
            description: 'Alaska Sub-boreal Mountain Hemlock-White Spruce Forest',
          },
          {
            value: 2480,
            color: '7fff00',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2481,
            color: 'd1d1d1',
            description: 'North Pacific Alpine and Subalpine Bedrock and Scree',
          },
          {
            value: 2482,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Boreal',
          },
          {
            value: 2483,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Alaska Sub-boreal',
          },
          {
            value: 2484,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2485,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Boreal',
          },
          {
            value: 2486,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Alaska Sub-boreal',
          },
          {
            value: 2487,
            color: '00d100',
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 2488,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2489,
            color: 'd1b28c',
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 2490,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Boreal',
          },
          {
            value: 2491,
            color: '75f9d3',
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 2492,
            color: '60f2d1',
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2493,
            color: '59edd1',
            description: 'Western North American Boreal Herbaceous Fen - Alaska Sub-Boreal Complex',
          },
          {
            value: 2494,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-Tree Peatland - Boreal Complex',
          },
          {
            value: 2495,
            color: '3fe0d1',
            description: 'Western North American Boreal Black Spruce Dwarf-Tree Peatland - Alaska Sub-boreal Complex',
          },
          {
            value: 2496,
            color: '9e1eef',
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 2497,
            color: 'e2f2e2',
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 2498,
            color: 'afe0e5',
            description: 'Western North American Boreal Alpine Floodplain - Lower Elevations',
          },
          {
            value: 2499,
            color: 'af381c',
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 2500,
            color: 'ccaf93',
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 2501,
            color: 'a0512b',
            description: 'Aleutian Mesic-Wet Willow Shrubland',
          },
          {
            value: 2502,
            color: '006300',
            description: 'Aleutian Kenai Birch-Cottonwood-Poplar Forest',
          },
          {
            value: 2503,
            color: 'edc600',
            description: 'Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2504,
            color: '00ff00',
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 2505,
            color: 'fff9cc',
            description: 'Alaskan Pacific Maritime Mesic Herbaceous Meadow',
          },
          {
            value: 2506,
            color: '3fe0d1',
            description: 'Alaskan Pacific Maritime Floodplain Forest and Shrubland',
          },
          {
            value: 2508,
            color: 'ffbfcc',
            description: 'North Pacific Shrub Swamp',
          },
          {
            value: 2509,
            color: 'ed82ed',
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 2510,
            color: 'ffff9e',
            description: 'North Pacific Maritime Eelgrass Bed',
          },
          {
            value: 2511,
            color: 'adaa00',
            description: 'Aleutian American Dunegrass Grassland',
          },
          {
            value: 2512,
            color: '7fff00',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2513,
            color: 'f2ddb2',
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland - Infrequent Fire',
          },
          {
            value: 2514,
            color: 'bfbfbf',
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 2515,
            color: 'e5e5f9',
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 2516,
            color: 'c1b7e8',
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 2517,
            color: 'edc191',
            description: 'Alaska Arctic Dwarf-Shrubland - Frequent Fire',
          },
          {
            value: 2518,
            color: 'bfd8d8',
            description: 'Alaska Arctic Tussock Tundra - Infrequent Fire',
          },
          {
            value: 2519,
            color: 'c1ffc1',
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 2520,
            color: 'eded00',
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 2521,
            color: 'ff8247',
            description: 'Alaska Arctic Coastal Sedge-Dwarf-Shrubland',
          },
          {
            value: 2522,
            color: 'e0eded',
            description: 'Alaska Arctic Wet Sedge-Sphagnum Peatland',
          },
          {
            value: 2523,
            color: '00bfff',
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 2524,
            color: 'fff28e',
            description: 'Alaska Arctic Marine Beach and Beach Meadow',
          },
          {
            value: 2525,
            color: 'ede0e5',
            description: 'Alaska Arctic Tidal Marsh',
          },
          {
            value: 2526,
            color: '63b7ff',
            description: 'Alaska Arctic Coastal Brackish Meadow',
          },
          {
            value: 2527,
            color: '0f4f8c',
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 2528,
            color: 'afcec1',
            description: 'Aleutian Rocky Headland and Sea Cliff',
          },
          {
            value: 2529,
            color: 'a0515e',
            description: 'Aleutian Mesic Alder-Salmonberry Shrubland',
          },
          {
            value: 2530,
            color: 'bf8e28',
            description: 'Aleutian Crowberry-Herbaceous Heath',
          },
          {
            value: 2531,
            color: 'd1b28c',
            description: 'Aleutian Mixed Dwarf-Shrub-Herbaceous Shrubland',
          },
          {
            value: 2532,
            color: 'ffa500',
            description: 'Aleutian Freshwater Marsh',
          },
          {
            value: 2533,
            color: 'ffd600',
            description: 'Aleutian Wet Meadow and Herbaceous Peatland - Complex',
          },
          {
            value: 2534,
            color: 'ffc691',
            description: 'Aleutian Marine Beach and Beach Meadow',
          },
          {
            value: 2535,
            color: 'c9e233',
            description: 'Aleutian Tidal Marsh',
          },
          {
            value: 2536,
            color: 'a0512b',
            description: 'Aleutian Shrub and Herbaceous Meadow Floodplain',
          },
          {
            value: 2537,
            color: 'efa000',
            description: 'Aleutian Floodplain Forest and Shrubland',
          },
          {
            value: 2538,
            color: 'ba822b',
            description: 'Aleutian Floodplain Wetland',
          },
          {
            value: 2539,
            color: 'a09677',
            description: 'Aleutian Sparse Heath and Fell-Field',
          },
          {
            value: 2540,
            color: 'a52828',
            description: 'Aleutian Oval-leaf Blueberry Shrubland',
          },
          {
            value: 2541,
            color: '4c3833',
            description: 'Aleutian Volcanic Rock and Talus',
          },
          {
            value: 2542,
            color: '007700',
            description: 'Western North American Boreal Treeline White Spruce Woodland - Alaska Sub-boreal',
          },
          {
            value: 2543,
            color: '00a500',
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2544,
            color: '00bc00',
            description: 'Western North American Boreal Mesic Black Spruce Forest - Alaska Sub-boreal',
          },
          {
            value: 2545,
            color: '00ff00',
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 2546,
            color: 'a52626',
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland - Alaska Sub-boreal',
          },
          {
            value: 2547,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 2548,
            color: '00ff00',
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 2549,
            color: 'edc600',
            description: 'Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 2550,
            color: '3f9900',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest - Northern',
          },
          {
            value: 2551,
            color: 'b7cc33',
            description: 'Alaskan Pacific Maritime Periglacial Woodland and Shrubland',
          },
          {
            value: 2552,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Subalpine Alder-Salmonberry Shrubland',
          },
          {
            value: 2553,
            color: '38c65e',
            description: 'Alaskan Pacific Maritime Sitka Spruce Beach Ridge',
          },
          {
            value: 2554,
            color: '38c65e',
            description: 'Alaskan Pacific Maritime Sitka Spruce Beach Ridge',
          },
          {
            value: 2555,
            color: 'afe0e5',
            description: 'Alaskan Pacific Maritime Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 2556,
            color: '008c00',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Peatland',
          },
          {
            value: 2557,
            color: '008c00',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Peatland',
          },
          {
            value: 2558,
            color: '7fffd1',
            description: 'Alaskan Pacific Maritime Wet Low Shrubland',
          },
          {
            value: 2560,
            color: 'e0ffff',
            description: 'Alaskan Pacific Maritime Fen and Wet Meadow',
          },
          {
            value: 2561,
            color: 'afeded',
            description: 'Temperate Pacific Freshwater Emergent Marsh',
          },
          {
            value: 2562,
            color: 'ffbfcc',
            description: 'North Pacific Shrub Swamp',
          },
          {
            value: 2563,
            color: 'ffefdb',
            description: 'Alaskan Pacific Maritime Coastal Meadow and Slough-Levee',
          },
          {
            value: 2564,
            color: 'ed82ed',
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 2565,
            color: 'ffffe0',
            description: 'Alaskan Pacific Maritime Alpine Wet Meadow',
          },
          {
            value: 2566,
            color: 'ffb5bf',
            description: 'Alaskan Pacific Maritime Alpine Floodplain',
          },
          {
            value: 2567,
            color: '7fff00',
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 2568,
            color: 'ffa077',
            description: 'Alaskan Pacific Maritime Avalanche Slope Shrubland',
          },
          {
            value: 2569,
            color: 'c9ff70',
            description: 'Alaskan Pacific Maritime Poorly Drained Conifer Woodland',
          },
          {
            value: 2570,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 2571,
            color: '00ff00',
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 2572,
            color: '005600',
            description: 'Alaskan Pacific Maritime Western Hemlock Forest',
          },
          {
            value: 2573,
            color: '3f9900',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest - Northern',
          },
          {
            value: 2574,
            color: '6b9368',
            description: 'Aleutian Mesic Herbaceous Meadow',
          },
          {
            value: 2575,
            color: '6b9368',
            description: 'Aleutian Mesic Herbaceous Meadow',
          },
          {
            value: 2576,
            color: 'd1b28c',
            description: 'Alaskan Pacific Maritime Subalpine Alder-Salmonberry Shrubland',
          },
          {
            value: 2577,
            color: '38c65e',
            description: 'Alaskan Pacific Maritime Sitka Spruce Beach Ridge',
          },
          {
            value: 2578,
            color: '3fe0d1',
            description: 'Alaskan Pacific Maritime Floodplain Forest and Shrubland',
          },
          {
            value: 2579,
            color: '56a88c',
            description: 'Alaskan Pacific Maritime Shore Pine Peatland',
          },
          {
            value: 2580,
            color: '008c00',
            description: 'Alaskan Pacific Maritime Mountain Hemlock Peatland',
          },
          {
            value: 2581,
            color: '7fffd1',
            description: 'Alaskan Pacific Maritime Wet Low Shrub',
          },
          {
            value: 2582,
            color: '7fffd1',
            description: 'Alaskan Pacific Maritime Wet Low Shrubland',
          },
          {
            value: 2584,
            color: 'e0ffff',
            description: 'Alaskan Pacific Maritime Fen and Wet Meadow',
          },
          {
            value: 2585,
            color: 'afeded',
            description: 'Temperate Pacific Freshwater Emergent Marsh',
          },
          {
            value: 2586,
            color: 'ffbfcc',
            description: 'North Pacific Shrub Swamp',
          },
          {
            value: 2587,
            color: 'ffefdb',
            description: 'Alaskan Pacific Maritime Coastal Meadow and Slough-Levee',
          },
          {
            value: 2588,
            color: 'ed82ed',
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 2589,
            color: 'ffffe0',
            description: 'Alaskan Pacific Maritime Alpine Wet Meadow',
          },
          {
            value: 2590,
            color: 'ffa077',
            description: 'Alaskan Pacific Maritime Avalanche Slope Shrubland',
          },
          {
            value: 2591,
            color: 'c9ff70',
            description: 'Alaskan Pacific Maritime Poorly Drained Conifer Woodland',
          },
          {
            value: 2592,
            color: '9e512b',
            description: 'Western North American Boreal Alpine Talus and Bedrock',
          },
          {
            value: 2593,
            color: '9e512b',
            description: 'Western North American Boreal Alpine Talus and Bedrock',
          },
          {
            value: 2594,
            color: '9e512b',
            description: 'Western North American Boreal Alpine Talus and Bedrock',
          },
          {
            value: 2595,
            color: '9e512b',
            description: 'Western North American Boreal Alpine Talus and Bedrock',
          },
          {
            value: 2596,
            color: '9e1eef',
            description: 'Hawaii Freshwater Marsh',
          },
          {
            value: 2597,
            color: 'ff00ff',
            description: 'Hawaii Bog',
          },
          {
            value: 2598,
            color: '006300',
            description: 'Hawaii Lowland Rainforest',
          },
          {
            value: 2599,
            color: '007700',
            description: 'Hawaii Montane Cloud Forest',
          },
          {
            value: 2600,
            color: '008e00',
            description: 'Hawaii Montane Rainforest',
          },
          {
            value: 2601,
            color: 'a52828',
            description: 'Hawaii Wet Cliff and Ridge Crest Shrubland',
          },
          {
            value: 2602,
            color: '00bc00',
            description: 'Hawaii Lowland Dry Forest',
          },
          {
            value: 2603,
            color: '00d100',
            description: 'Hawaii Lowland Mesic Forest',
          },
          {
            value: 2604,
            color: '00e800',
            description: 'Hawaii Montane-Subalpine Dry Forest and Woodland - Lava',
          },
          {
            value: 2605,
            color: '00ff00',
            description: 'Hawaii Montane-Subalpine Mesic Forest',
          },
          {
            value: 2606,
            color: 'aa3f3a',
            description: 'Hawaii Lowland Dry Shrubland',
          },
          {
            value: 2607,
            color: 'b55949',
            description: 'Hawaii Lowland Mesic Shrubland',
          },
          {
            value: 2608,
            color: 'ffd600',
            description: 'Hawaii Lowland Dry Grassland',
          },
          {
            value: 2609,
            color: 'ffe200',
            description: 'Hawaii Lowland Mesic Grassland',
          },
          {
            value: 2610,
            color: 'ba705b',
            description: 'Hawaii Montane-Subalpine Dry Shrubland',
          },
          {
            value: 2611,
            color: 'fff200',
            description: 'Hawaii Montane-Subalpine Dry Grassland',
          },
          {
            value: 2612,
            color: 'ffff00',
            description: 'Hawaii Montane-Subalpine Mesic Grassland',
          },
          {
            value: 2613,
            color: 'c1876b',
            description: 'Hawaii Alpine Dwarf-Shrubland',
          },
          {
            value: 2614,
            color: 'c99e77',
            description: 'Hawaii Dry Cliff',
          },
          {
            value: 2615,
            color: 'afe0e5',
            description: 'Hawaii Dry Coastal Strand',
          },
          {
            value: 2616,
            color: '47d1cc',
            description: 'Hawaii Wet-Mesic Coastal Strand',
          },
          {
            value: 2617,
            color: 'd1b58c',
            description: 'Hawaii Subalpine Mesic Shrubland',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'BPS',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'BPS',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    The suggested way to cite LANDFIRE products is specific to each product,
    so the model for citation is provided, with an example for a particular product.
    Producer. Year released. Product xxxxx:

    - Individual model name.
    - BpS Models and Descriptions, Online. LANDFIRE. Washington, DC. U.S. Department of
      Agriculture, Forest Service
    - U.S. Department of the Interior; U.S. Geological Survey; Arlington, VA
    - The Nature Conservancy (Producers). Available- URL. Access date.

    Example Citation: LANDFIRE Biophysical Settings. 2018. Biophysical setting 14420:
    South Texas sand sheet grassland. In: LANDFIRE Biophysical Setting Model: Map zone 36,
    [Online]. In: BpS Models and Descriptions. In: LANDFIRE. Washington, DC:
    U.S. Department of Agriculture, Forest Service; U.S. Department of the Interior;
    U.S. Geological Survey; Arlington, VA: The Nature Conservancy (Producers).
    Available: [https://www.landfire.gov/bps-models.php](https://www.landfire.gov/bps-models.php) [2018, June 27].
    Additional guidance on citation of LANDFIRE products can be found
    [here](https://landfire.gov/data/citation)
  |||,
  'gee:terms_of_use': |||
    LANDFIRE data are public domain data with no use restrictions, though if modifications
    or derivatives of the product(s) are created, then please add some descriptive modifier
    to the data set to avoid confusion.
  |||,
  'gee:user_uploaded': true,
}
