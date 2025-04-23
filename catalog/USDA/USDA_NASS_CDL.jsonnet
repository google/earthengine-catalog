local id = 'USDA/NASS/CDL';
local subdir = 'USDA';

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
  ],
  id: id,
  title: 'USDA NASS Cropland Data Layers',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Cropland Data Layer (CDL) is a crop-specific land cover data layer
    created annually for the continental United States using moderate
    resolution satellite imagery and extensive agricultural ground truth.
    The CDL is created by the USDA, National Agricultural Statistics
    Service (NASS), Research and Development Division, Geospatial
    Information Branch, Spatial Analysis Research Section.

    For detailed FAQ please visit [CropScape and Cropland Data
    Layers - FAQs](https://www.nass.usda.gov/Research_and_Science/Cropland/sarsfaqs2.php).

    To explore details about the classification accuracies and utility of
    the data, see
    [state-level omission and commission errors by crop type and year](https://www.nass.usda.gov/Research_and_Science/Cropland/metadata/meta.php).

    The asset date is aligned with the calendar year of harvest. For most crops
    the planted and harvest year are the same. Some exceptions: winter wheat is
    unique, as it is planted in the prior year. A hay crop like alfalfa could
    have been planted years prior.

    For winter wheat the data also have a class called
    "Double Crop Winter Wheat/Soybeans". Some mid-latitude areas of the US have
    conditions such that a second crop (usually soybeans) can be planted
    immediately after the harvest of winter wheat and itself still be harvested
    within the same year. So for mapping winter wheat areas use both classes
    (use both values 24 and 26).

    While the CDL date is aligned with year of harvest, the map itself is
    more representative of what was planted. In other words, a small percentage
    of fields on a given year will not be harvested.

    Some non-agricultural categories are duplicate due to
    [two very different epochs in methodology](https://www.google.com/url?sa=D&q=https%3A%2F%2Fwww.nass.usda.gov%2FResearch_and_Science%2FCropland%2F).

    The non-ag codes 63-65 and 81-88 are holdovers from the older
    methodology and will only appear in CDLs from 2007 and earlier. The non-ag
    codes from 111-195 are from the current methodology which uses the USGS NLCD
    as non-ag training and will only appear in CDLs 2007 and newer.

    2007 was a transition year so there may be both sets of categories in the
    2007 national product but will not appear within the same state.

    Note: The 2024 CDL only has the data band. The cultivated and
    confidence bands are yet to be released by the provider.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['agriculture'],
  keywords: [
    'cdl',
    'crop',
    'landcover',
    'nass',
    'usda',
  ],
  providers: [
    ee.producer_provider('USDA National Agricultural Statistics Service', 'https://www.nass.usda.gov/Research_and_Science/Cropland/SARS1a.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-127, 24, -65, 51, '1997-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'cropland_class_names',
        description: 'Array of cropland landcover classification names.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'cropland_class_palette',
        description:
          'Array of hex code color strings used for the classification ' +
          'palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'cropland_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
      {
        name: 'cultivated_class_names',
        description: 'Array of cropland landcover classification names.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'cultivated_class_palette',
        description:
          'Array of hex code color strings used for the classification ' +
          'palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'cultivated_class_values',
        description: 'Value of the land cover classification.',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [30],
    'eo:bands': [
      {
        name: 'cropland',
        description: 'Main crop-specific land cover classification.',
        'gee:classes': [
          { value: 0, color: '000000', description: 'Background' },
          { value: 1, color: 'ffd400', description: 'Corn' },
          { value: 2, color: 'ff2626', description: 'Cotton' },
          { value: 3, color: '00a9e6', description: 'Rice' },
          { value: 4, color: 'ff9e0f', description: 'Sorghum' },
          { value: 5, color: '267300', description: 'Soybeans' },
          { value: 6, color: 'ffff00', description: 'Sunflower' },
          { value: 10, color: '70a800', description: 'Peanuts' },
          { value: 11, color: '00af4d', description: 'Tobacco' },
          { value: 12, color: 'e0a60f', description: 'Sweet Corn' },
          { value: 13, color: 'e0a60f', description: 'Pop or Orn Corn' },
          { value: 14, color: '80d4ff', description: 'Mint' },
          { value: 21, color: 'e2007f', description: 'Barley' },
          { value: 22, color: '8a6453', description: 'Durum Wheat' },
          { value: 23, color: 'd9b56c', description: 'Spring Wheat' },
          { value: 24, color: 'a87000', description: 'Winter Wheat' },
          { value: 25, color: 'd69dbc', description: 'Other Small Grains' },
          { value: 26, color: '737300', description: 'Dbl Crop WinWht/Soybeans' },
          { value: 27, color: 'ae017e', description: 'Rye' },
          { value: 28, color: 'a15889', description: 'Oats' },
          { value: 29, color: '73004c', description: 'Millet' },
          { value: 30, color: 'd69dbc', description: 'Speltz' },
          { value: 31, color: 'd1ff00', description: 'Canola' },
          { value: 32, color: '8099ff', description: 'Flaxseed' },
          { value: 33, color: 'd6d600', description: 'Safflower' },
          { value: 34, color: 'd1ff00', description: 'Rape Seed' },
          { value: 35, color: '00af4d', description: 'Mustard' },
          { value: 36, color: 'ffa8e3', description: 'Alfalfa' },
          { value: 37, color: 'a5f58d', description: 'Other Hay/Non Alfalfa' },
          { value: 38, color: '00af4d', description: 'Camelina' },
          { value: 39, color: 'd69dbc', description: 'Buckwheat' },
          { value: 41, color: 'a900e6', description: 'Sugarbeets' },
          { value: 42, color: 'a80000', description: 'Dry Beans' },
          { value: 43, color: '732600', description: 'Potatoes' },
          { value: 44, color: '00af4d', description: 'Other Crops' },
          { value: 45, color: 'b380ff', description: 'Sugarcane' },
          { value: 46, color: '732600', description: 'Sweet Potatoes' },
          { value: 47, color: 'ff6666', description: 'Misc Vegs & Fruits' },
          { value: 48, color: 'ff6666', description: 'Watermelons' },
          { value: 49, color: 'ffcc66', description: 'Onions' },
          { value: 50, color: 'ff6666', description: 'Cucumbers' },
          { value: 51, color: '00af4d', description: 'Chick Peas' },
          { value: 52, color: '00deb0', description: 'Lentils' },
          { value: 53, color: '55ff00', description: 'Peas' },
          { value: 54, color: 'f5a27a', description: 'Tomatoes' },
          { value: 55, color: 'ff6666', description: 'Caneberries' },
          { value: 56, color: '00af4d', description: 'Hops' },
          { value: 57, color: '80d4ff', description: 'Herbs' },
          { value: 58, color: 'e8beff', description: 'Clover/Wildflowers' },
          { value: 59, color: 'b2ffde', description: 'Sod/Grass Seed' },
          { value: 60, color: '00af4d', description: 'Switchgrass' },
          { value: 61, color: 'bfbf7a', description: 'Fallow/Idle Cropland' },
          { value: 63, color: '95ce93', description: 'Forest' },
          { value: 64, color: 'c7d79e', description: 'Shrubland' },
          { value: 65, color: 'ccbfa3', description: 'Barren' },
          { value: 66, color: 'ff00ff', description: 'Cherries' },
          { value: 67, color: 'ff91ab', description: 'Peaches' },
          { value: 68, color: 'b90050', description: 'Apples' },
          { value: 69, color: '704489', description: 'Grapes' },
          { value: 70, color: '007878', description: 'Christmas Trees' },
          { value: 71, color: 'b39c70', description: 'Other Tree Crops' },
          { value: 72, color: 'ffff80', description: 'Citrus' },
          { value: 74, color: 'b6705c', description: 'Pecans' },
          { value: 75, color: '00a884', description: 'Almonds' },
          { value: 76, color: 'ebd6b0', description: 'Walnuts' },
          { value: 77, color: 'b39c70', description: 'Pears' },
          { value: 81, color: 'f7f7f7', description: 'Clouds/No Data' },
          { value: 82, color: '9c9c9c', description: 'Developed' },
          { value: 83, color: '4d70a3', description: 'Water' },
          { value: 87, color: '80b3b3', description: 'Wetlands' },
          { value: 88, color: 'e9ffbe', description: 'Nonag/Undefined' },
          { value: 92, color: '00ffff', description: 'Aquaculture' },
          { value: 111, color: '4d70a3', description: 'Open Water' },
          { value: 112, color: 'd4e3fc', description: 'Perennial Ice/Snow' },
          { value: 121, color: '9c9c9c', description: 'Developed/Open Space' },
          { value: 122, color: '9c9c9c', description: 'Developed/Low Intensity' },
          { value: 123, color: '9c9c9c', description: 'Developed/Med Intensity' },
          { value: 124, color: '9c9c9c', description: 'Developed/High Intensity' },
          { value: 131, color: 'ccbfa3', description: 'Barren' },
          { value: 141, color: '95ce93', description: 'Deciduous Forest' },
          { value: 142, color: '95ce93', description: 'Evergreen Forest' },
          { value: 143, color: '95ce93', description: 'Mixed Forest' },
          { value: 152, color: 'c7d79e', description: 'Shrubland' },
          { value: 176, color: 'e9ffbe', description: 'Grass/Pasture' },
          { value: 190, color: '80b3b3', description: 'Woody Wetlands' },
          { value: 195, color: '80b3b3', description: 'Herbaceous Wetlands' },
          { value: 204, color: '00ff8c', description: 'Pistachios' },
          { value: 205, color: 'd69dbc', description: 'Triticale' },
          { value: 206, color: 'ff6666', description: 'Carrots' },
          { value: 207, color: 'ff6666', description: 'Asparagus' },
          { value: 208, color: 'ff6666', description: 'Garlic' },
          { value: 209, color: 'ff6666', description: 'Cantaloupes' },
          { value: 210, color: 'ff91ab', description: 'Prunes' },
          { value: 211, color: '344a34', description: 'Olives' },
          { value: 212, color: 'e67525', description: 'Oranges' },
          { value: 213, color: 'ff6666', description: 'Honeydew Melons' },
          { value: 214, color: 'ff6666', description: 'Broccoli' },
          { value: 215, color: '66994d', description: 'Avocados' },
          { value: 216, color: 'ff6666', description: 'Peppers' },
          { value: 217, color: 'b39c70', description: 'Pomegranates' },
          { value: 218, color: 'ff91ab', description: 'Nectarines' },
          { value: 219, color: 'ff6666', description: 'Greens' },
          { value: 220, color: 'ff91ab', description: 'Plums' },
          { value: 221, color: 'ff6666', description: 'Strawberries' },
          { value: 222, color: 'ff6666', description: 'Squash' },
          { value: 223, color: 'ff91ab', description: 'Apricots' },
          { value: 224, color: '00af4d', description: 'Vetch' },
          { value: 225, color: 'ffd400', description: 'Dbl Crop WinWht/Corn' },
          { value: 226, color: 'ffd400', description: 'Dbl Crop Oats/Corn' },
          { value: 227, color: 'ff6666', description: 'Lettuce' },
          { value: 228, color: 'ffd400', description: 'Dbl Crop Triticale/Corn' },
          { value: 229, color: 'ff6666', description: 'Pumpkins' },
          {
            value: 230,
            color: '8a6453',
            description: 'Dbl Crop Lettuce/Durum Wht',
          },
          {
            value: 231,
            color: 'ff6666',
            description: 'Dbl Crop Lettuce/Cantaloupe',
          },
          { value: 232, color: 'ff2626', description: 'Dbl Crop Lettuce/Cotton' },
          { value: 233, color: 'e2007f', description: 'Dbl Crop Lettuce/Barley' },
          {
            value: 234,
            color: 'ff9e0f',
            description: 'Dbl Crop Durum Wht/Sorghum',
          },
          { value: 235, color: 'ff9e0f', description: 'Dbl Crop Barley/Sorghum' },
          { value: 236, color: 'a87000', description: 'Dbl Crop WinWht/Sorghum' },
          { value: 237, color: 'ffd400', description: 'Dbl Crop Barley/Corn' },
          { value: 238, color: 'a87000', description: 'Dbl Crop WinWht/Cotton' },
          { value: 239, color: '267300', description: 'Dbl Crop Soybeans/Cotton' },
          { value: 240, color: '267300', description: 'Dbl Crop Soybeans/Oats' },
          { value: 241, color: 'ffd400', description: 'Dbl Crop Corn/Soybeans' },
          { value: 242, color: '000099', description: 'Blueberries' },
          { value: 243, color: 'ff6666', description: 'Cabbage' },
          { value: 244, color: 'ff6666', description: 'Cauliflower' },
          { value: 245, color: 'ff6666', description: 'Celery' },
          { value: 246, color: 'ff6666', description: 'Radishes' },
          { value: 247, color: 'ff6666', description: 'Turnips' },
          { value: 248, color: 'ff6666', description: 'Eggplants' },
          { value: 249, color: 'ff6666', description: 'Gourds' },
          { value: 250, color: 'ff6666', description: 'Cranberries' },
          { value: 254, color: '267300', description: 'Dbl Crop Barley/Soybeans' },
        ],
      },
      {
        name: 'cultivated',
        description:
          'Classification layer for identifying cultivated and ' +
          'non-cultivated land cover. Available from 2013 to 2023.',
        'gee:classes': [
          { value: 1, color: 'd3d3d3', description: 'Non-cultivated' },
          { value: 2, color: 'b1b58c', description: 'Cultivated' },
        ],
      },
      {
        name: 'confidence',
        description: |||
          Per-pixel predicted confidence of the given classification,
          with 0 being the least confident and 100 the most confident. Available
          from 2008 to 2023 (Note: Confidence for Florida and Washington D.C.
          is unavailable for 2010).
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Crop Landcover',
        lookat: { lon: -100.55, lat: 40.71, zoom: 2 },
        image_visualization: {
          band_vis: {
            min: [11],
            max: [95],
            palette: [
              'ffd400',
              'ff2626',
              '00a9e6',
              'ff9e0f',
              '267300',
              'ffff00',
              '70a800',
              '00af4d',
              'e0a60f',
              'e0a60f',
              '80d4ff',
              'e2007f',
              '8a6453',
              'd9b56c',
              'a87000',
              'd69dbc',
              '737300',
              'ae017e',
              'a15889',
              '73004c',
              'd69dbc',
              'd1ff00',
              '8099ff',
              'd6d600',
              'd1ff00',
              '00af4d',
              'ffa8e3',
              'a5f58d',
              '00af4d',
              'd69dbc',
              'a900e6',
              'a80000',
              '732600',
              '00af4d',
              'b380ff',
              '732600',
              'ff6666',
              'ff6666',
              'ffcc66',
              'ff6666',
              '00af4d',
              '00deb0',
              '55ff00',
              'f5a27a',
              'ff6666',
              '00af4d',
              '80d4ff',
              'e8beff',
              'b2ffde',
              '00af4d',
              'bfbf7a',
              '95ce93',
              'c7d79e',
              'ccbfa3',
              'ff00ff',
              'ff91ab',
              'b90050',
              '704489',
              '007878',
              'b39c70',
              'ffff80',
              'b6705c',
              '00a884',
              'ebd6b0',
              'b39c70',
              'f7f7f7',
              '9c9c9c',
              '4d70a3',
              '80b3b3',
              'e9ffbe',
              '00ffff',
              '4d70a3',
              'd4e3fc',
              '9c9c9c',
              '9c9c9c',
              '9c9c9c',
              '9c9c9c',
              'ccbfa3',
              '95ce93',
              '95ce93',
              '95ce93',
              'c7d79e',
              'e9ffbe',
              '80b3b3',
              '80b3b3',
              '00ff8c',
              'd69dbc',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff91ab',
              '344a34',
              'e67525',
              'ff6666',
              'ff6666',
              '66994d',
              'ff6666',
              'b39c70',
              'ff91ab',
              'ff6666',
              'ff91ab',
              'ff6666',
              'ff6666',
              'ff91ab',
              '00af4d',
              'ffd400',
              'ffd400',
              'ff6666',
              'ffd400',
              'ff6666',
              '8a6453',
              'ff6666',
              'ff2626',
              'e2007f',
              'ff9e0f',
              'ff9e0f',
              'a87000',
              'ffd400',
              'a87000',
              '267300',
              '267300',
              'ffd400',
              '000099',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              'ff6666',
              '267300',
            ],
            bands: ['cropland'],
          },
        },
      },
    ],
    cropland: { minimum: 1, maximum: 254, 'gee:estimated_range': false },
    cultivated: { minimum: 1, maximum: 2, 'gee:estimated_range': false },
    confidence: { minimum: 0, maximum: 100, 'gee:estimated_range': false },
  },
  'sci:citation': |||
    USDA National Agricultural Statistics Service Cropland Data Layer. {YEAR}.
    Published crop-specific data layer [Online]. Available at
    [https://nassgeodata.gmu.edu/CropScape/](https://nassgeodata.gmu.edu/CropScape/)
    (accessed {DATE}; verified {DATE}). USDA-NASS, Washington, DC.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The NASS Cropland Data Layer has no copyright restrictions. The CDL is
    considered public domain and free to redistribute. However, NASS would
    appreciate acknowledgment for the usage of our CDL product.
  |||,
}
