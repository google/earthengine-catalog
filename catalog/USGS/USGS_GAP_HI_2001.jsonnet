local id = 'USGS/GAP/HI/2001';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS GAP Hawaii 2001',
  version: '2001',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GAP/LANDFIRE National Terrestrial Ecosystems data represents a detailed
    vegetation and land cover classification for the Conterminous U.S., Alaska,
    Hawaii, and Puerto Rico.GAP/LF 2011 Ecosystems for the Conterminous U.S. is
    an update of the National Gap Analysis Program Land Cover Data - Version 2.2.
    Alaska ecosystems have been updated by LANDFIRE to 2012 conditions (LANDFIRE 2012).
    Hawaii and Puerto Rico data represent the 2001 time-frame (Gon et al. 2006, Gould et al. 2008).
    The classification scheme used for the Alaska and the lower 48 states is based
    on NatureServe's Ecological System Classification (Comer et al. 2003), while
    Puerto Rico and Hawaii's map legend are based on island specific classification
    systems (Gon et al. 2006, Gould et al. 2008).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'gap',
    'landcover',
    'landfire',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://gapanalysis.usgs.gov/gaplandcover/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-160.2665484663998, 18.851697692492277, -154.669588436752, 22.295218441899475,
                    '2001-01-01T00:00:00Z', '2002-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Landcover class descriptions',
        'gee:classes': [
          {
            value: 1,
            color: '7C009C',
            description: 'Mixed Native-Alien Forest',
          },
          {
            value: 2,
            color: 'C14F00',
            description: 'Mixed Native-Alien Shrubs and Grasses',
          },
          {
            value: 3,
            color: 'C1E09E',
            description: 'Native Coastal Vegetation',
          },
          {
            value: 4,
            color: 'EF0047',
            description: 'Deschampsia Grassland',
          },
          {
            value: 5,
            color: 'D67900',
            description: 'Aalii Shrubland',
          },
          {
            value: 6,
            color: '00E3EB',
            description: 'Bog Vegetation',
          },
          {
            value: 7,
            color: 'CCBF70',
            description: 'Native Dry Cliff Vegetation',
          },
          {
            value: 8,
            color: '7C7047',
            description: 'Native Shrubland / Sparse Ohia (native shrubs)',
          },
          {
            value: 9,
            color: '617000',
            description: 'Native Wet Cliff Vegetation',
          },
          {
            value: 10,
            color: '66E805',
            description: 'Open Mao Shrubland',
          },
          {
            value: 11,
            color: 'BF6B00',
            description: 'Uluhe Shrubland',
          },
          {
            value: 12,
            color: '9BCC9B',
            description: 'Closed Hala Forest',
          },
          {
            value: 13,
            color: '008F99',
            description: 'Closed Koa-Ohia Forest',
          },
          {
            value: 14,
            color: '009C61',
            description: 'Closed Ohia Forest',
          },
          {
            value: 15,
            color: '2BCF56',
            description: 'Closed Pouteria Forest (native trees)',
          },
          {
            value: 16,
            color: '3FF2BF',
            description: 'Koa Forest',
          },
          {
            value: 17,
            color: '9B9B4C',
            description: 'Mamane / Naio / Native Trees',
          },
          {
            value: 18,
            color: '8EBC00',
            description: 'Native Mesic to Dry Forest and Shrubland',
          },
          {
            value: 19,
            color: '33C7A6',
            description: 'Native Wet Forest and Shrubland',
          },
          {
            value: 20,
            color: '7FBF00',
            description: 'Ohia Forest',
          },
          {
            value: 21,
            color: '007F7F',
            description: 'Olopua-Lama Forest',
          },
          {
            value: 22,
            color: 'B3ED7F',
            description: 'Open Koa-Mamane Forest',
          },
          {
            value: 23,
            color: '21AB33',
            description: 'Open Koa-Ohia Forest',
          },
          {
            value: 24,
            color: '000000',
            description: 'Open Ohia Forest',
          },
          {
            value: 25,
            color: '002DC2',
            description: 'Open Water',
          },
          {
            value: 26,
            color: 'AFE200',
            description: 'Wetland Vegetation',
          },
          {
            value: 27,
            color: 'FEFEC1',
            description: 'Agriculture',
          },
          {
            value: 28,
            color: 'EB3642',
            description: 'High Intensity Developed',
          },
          {
            value: 29,
            color: 'C94D42',
            description: 'Low Intensity Developed',
          },
          {
            value: 30,
            color: 'CCB8BF',
            description: 'Alien Grassland',
          },
          {
            value: 31,
            color: '9F298C',
            description: 'Alien Shrubland',
          },
          {
            value: 32,
            color: '75009C',
            description: 'Alien Forest',
          },
          {
            value: 33,
            color: '460075',
            description: 'Kiawe Forest and Shrubland',
          },
          {
            value: 34,
            color: '001493',
            description: 'Uncharacterized Forest',
          },
          {
            value: 35,
            color: 'EDEDED',
            description: 'Uncharacterized Open-Sparse Vegetation',
          },
          {
            value: 36,
            color: 'D99485',
            description: 'Uncharacterized Shrubland',
          },
          {
            value: 37,
            color: '6B6B6B',
            description: 'Very Sparse Vegetation to Unvegetated',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'GAP Hawaii',
        lookat: {
          lat: 20.1,
          lon: -157.0,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              37.0,
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 1.0,
      maximum: 9.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Gon, S.M., A. Allison, R. J. Cannarella, J. D. Jacobi, K. Y. Kaneshiro,
    M. H. Kido, M. Lane-Kamehele, S. E. Miller.  2006.  The Hawaii Gap Analysis
    Project Final Report. 487 pp.
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
