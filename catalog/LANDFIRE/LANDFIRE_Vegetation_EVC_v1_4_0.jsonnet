local id = 'LANDFIRE/Vegetation/EVC/v1_4_0';
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
  title: 'LANDFIRE EVC (Existing Vegetation Cover) v1.4.0',
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

    LANDFIRE's (LF) Existing Vegetation Cover (EVC) represents the vertically projected percent cover of the live canopy layer for a 30-m cell.
    EVC is generated separately for tree, shrub, and herbaceous cover lifeforms using training data and other geospatial layers. Percentage tree, shrub, and herbaceous canopy cover training data are generated using plot-level ground-based visual assessments and lidar observations.
    * Once the training data are developed, relationships are then established separately for each lifeform between the training data and combination of Landsat and ancillary data. Each of the derived data layers (tree, shrub, herbaceous) has a potential range from 0-100 percent which are merged into a single composite EVC layer.
    * Disturbance data were used to develop LF Remap products for LFRDB plot filtering and to ensure 2015 and 2016 disturbances were included that were not visible in the source imagery.
    * The EVC product is then reconciled through QA/QC measures to ensure life-form is synchronized with both Existing Vegetation Height and Existing Vegetation Type products.
    LF uses EVC in several subsequent layers, including the development of the fuel layers.

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
        name: 'EVC_classes',
        description: 'Class values of the Existing Vegetation Cover.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EVC_names',
        description: 'Descriptive names of the Existing Vegetation Cover.',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'EVC',
        description: 'Existing Vegetation Cover',
        'gee:classes': [
          {
            value: 11,
            color: '0000ff',
            description: 'Open Water',
          },
          {
            value: 12,
            color: '9fa1f0',
            description: 'Snow/Ice',
          },
          {
            value: 13,
            color: '403da8',
            description: 'Developed-Upland Deciduous Forest',
          },
          {
            value: 14,
            color: '444f89',
            description: 'Developed-Upland Evergreen Forest',
          },
          {
            value: 15,
            color: '6677cd',
            description: 'Developed-Upland Mixed Forest',
          },
          {
            value: 16,
            color: '7a8ef5',
            description: 'Developed-Upland Herbaceous',
          },
          {
            value: 17,
            color: '9eaad7',
            description: 'Developed-Upland Shrubland',
          },
          {
            value: 18,
            color: '343434',
            description: 'Developed-Herbaceous Wetland Vegetation',
          },
          {
            value: 19,
            color: '343434',
            description: 'Developed-Woody Wetland Vegetation',
          },
          {
            value: 20,
            color: 'ffebe0',
            description: 'Developed - General',
          },
          {
            value: 21,
            color: 'fdccd3',
            description: 'Developed - Open Space',
          },
          {
            value: 22,
            color: 'ff7a8f',
            description: 'Developed - Low Intensity',
          },
          {
            value: 23,
            color: 'fd2c4f',
            description: 'Developed - Medium Intensity',
          },
          {
            value: 24,
            color: 'ad001c',
            description: 'Developed - High Intensity',
          },
          {
            value: 25,
            color: '010101',
            description: 'Developed-Roads',
          },
          {
            value: 31,
            color: 'bfbfbf',
            description: 'Barren',
          },
          {
            value: 32,
            color: 'e6e8fa',
            description: 'Quarries-Strip Mines-Gravel Pits',
          },
          {
            value: 60,
            color: 'd21c5e',
            description: 'NASS-Orchard',
          },
          {
            value: 61,
            color: 'a80084',
            description: 'NASS-Vineyard',
          },
          {
            value: 62,
            color: 'd21c77',
            description: 'NASS-Bush fruit and berries',
          },
          {
            value: 63,
            color: 'fff58c',
            description: 'NASS-Row Crop-Close Grown Crop',
          },
          {
            value: 64,
            color: 'faff77',
            description: 'NASS-Row Crop',
          },
          {
            value: 65,
            color: 'ffed77',
            description: 'NASS-Close Grown Crop',
          },
          {
            value: 66,
            color: 'ffff77',
            description: 'NASS-Fallow/Idle Cropland',
          },
          {
            value: 67,
            color: 'e3d41c',
            description: 'NASS-Pasture and Hayland',
          },
          {
            value: 68,
            color: 'fae3a3',
            description: 'NASS-Wheat',
          },
          {
            value: 69,
            color: 'd2ffed',
            description: 'NASS-Aquaculture',
          },
          {
            value: 75,
            color: '7f38ff',
            description: 'Herbaceous Semi-dry',
          },
          {
            value: 76,
            color: '7f38ff',
            description: 'Herbaceous Semi-wet',
          },
          {
            value: 78,
            color: '7f382b',
            description: 'Recently Disturbed Forest',
          },
          {
            value: 80,
            color: 'ffffbf',
            description: 'Agriculture - General',
          },
          {
            value: 81,
            color: 'ffff9c',
            description: 'Pasture/Hay',
          },
          {
            value: 82,
            color: 'ffff78',
            description: 'Cultivated Crops',
          },
          {
            value: 83,
            color: 'ffff54',
            description: 'Small Grains',
          },
          {
            value: 84,
            color: 'ffff2b',
            description: 'Fallow',
          },
          {
            value: 85,
            color: 'ffff00',
            description: 'Urban-Recreational Grasses',
          },
          {
            value: 95,
            color: '7f8fff',
            description: 'Herbaceous Wetlands',
          },
          {
            value: 100,
            color: '7a7f75',
            description: 'Sparse Vegetation Canopy',
          },
          {
            value: 101,
            color: 'ccff99',
            description: 'Tree Cover >= 10 and < 20%',
          },
          {
            value: 102,
            color: 'aee082',
            description: 'Tree Cover >= 20 and < 30%',
          },
          {
            value: 103,
            color: '91c46c',
            description: 'Tree Cover >= 30 and < 40%',
          },
          {
            value: 104,
            color: '77ab57',
            description: 'Tree Cover >= 40 and < 50%',
          },
          {
            value: 105,
            color: '5e9144',
            description: 'Tree Cover >= 50 and < 60%',
          },
          {
            value: 106,
            color: '467832',
            description: 'Tree Cover >= 60 and < 70%',
          },
          {
            value: 107,
            color: '336324',
            description: 'Tree Cover >= 70 and < 80%',
          },
          {
            value: 108,
            color: '204f16',
            description: 'Tree Cover >= 80 and < 90%',
          },
          {
            value: 109,
            color: '003300',
            description: 'Tree Cover >= 90 and <= 100%',
          },
          {
            value: 111,
            color: 'd4b27d',
            description: 'Shrub Cover >= 10 and < 20%',
          },
          {
            value: 112,
            color: 'd1a171',
            description: 'Shrub Cover >= 20 and < 30%',
          },
          {
            value: 113,
            color: 'cc9166',
            description: 'Shrub Cover >= 30 and < 40%',
          },
          {
            value: 114,
            color: 'c77e5a',
            description: 'Shrub Cover >= 40 and < 50%',
          },
          {
            value: 115,
            color: 'c26e4f',
            description: 'Shrub Cover >= 50 and < 60%',
          },
          {
            value: 116,
            color: 'bd5e46',
            description: 'Shrub Cover >= 60 and < 70%',
          },
          {
            value: 117,
            color: 'b54c3c',
            description: 'Shrub Cover >= 70 and < 80%',
          },
          {
            value: 118,
            color: 'b03b33',
            description: 'Shrub Cover >= 80 and < 90%',
          },
          {
            value: 119,
            color: '9e0020',
            description: 'Shrub Cover >= 90 and <= 100%',
          },
          {
            value: 121,
            color: 'ffcc66',
            description: 'Herb Cover >= 10 and < 20%',
          },
          {
            value: 122,
            color: 'ffba59',
            description: 'Herb Cover >= 20 and < 30%',
          },
          {
            value: 123,
            color: 'ffa94d',
            description: 'Herb Cover >= 30 and < 40%',
          },
          {
            value: 124,
            color: 'ff9a42',
            description: 'Herb Cover >= 40 and < 50%',
          },
          {
            value: 125,
            color: 'ff8636',
            description: 'Herb Cover >= 50 and < 60%',
          },
          {
            value: 126,
            color: 'ff752b',
            description: 'Herb Cover >= 60 and < 70%',
          },
          {
            value: 127,
            color: 'ff6421',
            description: 'Herb Cover >= 70 and < 80%',
          },
          {
            value: 128,
            color: 'ff5517',
            description: 'Herb Cover >= 80 and < 90%',
          },
          {
            value: 129,
            color: 'ff3300',
            description: 'Herb Cover >= 90 and <= 100%',
          },
          {
            value: 150,
            color: '7a7f75',
            description: 'Sparse Vegetation Canopy',
          },
          {
            value: 151,
            color: 'ccff99',
            description: 'Tree Canopy >= 10 and < 25%',
          },
          {
            value: 152,
            color: '467832',
            description: 'Tree Canopy >= 25 and < 60%',
          },
          {
            value: 153,
            color: '003300',
            description: 'Tree Canopy >= 60 and <= 100%',
          },
          {
            value: 161,
            color: 'd4b27d',
            description: 'Shrub Canopy >= 10 and < 25%',
          },
          {
            value: 162,
            color: 'c26e4f',
            description: 'Shrub Canopy >= 25 and < 60%',
          },
          {
            value: 163,
            color: '9e0020',
            description: 'Shrub Canopy >= 60 and <= 100%',
          },
          {
            value: 171,
            color: 'ffa94d',
            description: 'Herb Canopy >= 10 and < 60%',
          },
          {
            value: 172,
            color: 'ff752b',
            description: 'Herb Canopy >= 60 and <= 100%',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'EVC',
        lookat: {
          lat: 40.699,
          lon: -121.671,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'EVC',
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
