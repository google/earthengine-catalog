local id = 'projects/geoscience-aus-cat/assets/ga_ls_landcover_class_cyear_2';
local subdir = 'geoscience-aus-cat';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local version = '1.0.0';

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
  version: version,
  title: 'DEA Land Cover ' + version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Digital Earth Australia (DEA) Land Cover provides annual land cover classifications for Australia using the Food and Agriculture Organisation Land Cover Classification System taxonomy Version 2 (Di Gregorio and Jansen, 1998; 2005).

    DEA Land Cover translates over 30 years of satellite imagery into evidence of how Australia's land, vegetation and waterbodies have changed over time.
    
    Land cover is the observed physical cover on the Earth's surface including trees, shrubs, grasses, soils, exposed rocks, water bodies, plantations, crops and built structures. A consistent, Australia-wide land cover product helps understanding of how the different parts of the environment change and inter-relate. Earth observation data recorded over a period of time firstly allows the observation of the state of land cover at a specific time and secondly the way that land cover changes by comparison between times.

    For more information, please see the [DEA Landcover Landsat](https://cmi.ga.gov.au/data-products/dea/607/dea-land-cover-landsat#basics)

    This product is part of the [Digital Earth Australia Program](https://www.dea.ga.gov.au/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.3390/data4040143',
      type: ee_const.media_type.html,
    },
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1080/20964471.2021.1948179',
      type: ee_const.media_type.html,
    },
    {
      rel: ee_const.rel.source,
      href: 'http://dea-public-data.s3-website-ap-southeast-2.amazonaws.com/?prefix=derivative/ga_ls_landcover_class_cyear_2/',
    },
  ],
  keywords: [
    'australia',
    'ga',
    'landsat_derived',
    'landcover'
  ],
  providers: [
    ee.producer_provider(
      'Geoscience Australia',
      'https://cmi.ga.gov.au/data-products/dea/607/dea-land-cover-landsat#basics'),
    ee.processor_provider('NGIS', 'https://ngis.com.au/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    108.81, -44.41, 157.82, -9.13,
    '1988-01-01T00:00:00Z', null),
  summaries: {
    gsd: [25],
    'eo:bands': [
      {
        name: 'baregrad_phy_cat_l4d',
        description: |||
          Bare gradation. Describes the percentage of bare in naturally bare areas.
        |||,
        'gee:classes':[
          {
            color: '622f22',
            description: 'Sparsely vegetated (< 20 % bare)',
            value: 10,
          },
          {
            color: '5c3317',
            description: 'Very sparsely vegetated (20 to 60 % bare)',
            value: 12,
          },
          {
            color: '804a00',
            description: 'Bare areas, unvegetated (> 60 % bare)',
            value: 15,
          },
        ],
      },
      {
        name: 'canopyco_veg_cat_l4d',
        description: |||
          Vegetation Cover. The measured cover of vegetated areas.
        |||,
        'gee:classes':[
          {
            color: '8fb31d',
            description: 'Closed (>65 %)',
            value: 10,
          },
          {
            color: 'b0bf1a',
            description: 'Open (40 to 65 %)',
            value: 12,
          },
          {
            color: '9dc209',
            description: 'Open (15 to 40 %)',
            value: 13,
          },
          {
            color: '77dd77',
            description: 'Sparse (4 to 15 %)',
            value: 15,
          },
          {
            color: '64e986',
            description: 'Scattered (1 to 4 %)',
            value: 16,
          },
        ],
      },
      {
        name: 'inttidal_wat_cat_l4a',
        description: |||
          Intertidal. Delineates the intertidal zone.
        |||,
        'gee:classes':[
          {
            color: '151b54',
            description: 'Intertidal zone',
            value: 3,
          },
        ],
      },
      {
        name: 'level3',
        description: |||
          The base Level 3 land cover classification.
        |||,
        'gee:classes':[
          {
            color: '4aa02c',
            description: 'Cultivated Terrestrial Vegetation (CTV)',
            value: 111,
          },
          {
            color: '54c571',
            description: '(Semi-)Natural Terrestrial Vegetation (NTV)',
            value: 112,
          },
          {
            color: '306eff',
            description: 'Natural Aquatic Vegetation (NAV)',
            value: 124,
          },
          {
            color: 'e6e6fa',
            description: 'Artificial Surface (AS)',
            value: 215,
          },
          {
            color: '5c3317',
            description: 'Natural Bare Surface (NS)',
            value: 216,
          },
          {
            color: '0020c2',
            description: 'Water',
            value: 220,
          },
        ],
      },
      {
        name: 'level3_R',
        description: |||
          R band of RGB composite for level 3 data.
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'level3_G',
        description: |||
          G band of RGB composite for level 3 data.
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'level3_B',
        description: |||
          B band of RGB composite for level 3 data.
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'level4',
        description: |||
          All level 3 and level 4 classes for a given pixel are combined to give a single classification value.
        |||,
        'gee:classes':[
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated',
            value: 1,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Herbaceous',
            value: 3,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Closed (> 65 %)',
            value: 4,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Open (40 to 65 %)',
            value: 5,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Open (15 to 40 %)',
            value: 6,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Sparse (4 to 15 %)',
            value: 7,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Scattered (1 to 4 %)',
            value: 8,
          },
          {
            color: '347c17',
            description: ' Cultivated Terrestrial Vegetated: Herbaceous Closed (> 65 %)',
            value: 14,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Herbaceous Open (40 to 65 %)',
            value: 15,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Herbaceous Open (15 to 40 %)',
            value: 16,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Herbaceous Sparse (4 to 15 %)',
            value: 17,
          },
          {
            color: '347c17',
            description: 'Cultivated Terrestrial Vegetated: Herbaceous Scattered (1 to 4 %)',
            value: 18,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated',
            value: 19,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody',
            value: 20,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Herbaceous',
            value: 21,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Closed (> 65 %)',
            value: 22,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Open (40 to 65 %)',
            value: 23,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Open (15 to 40 %)',
            value: 24,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Sparse (4 to 15 %)',
            value: 25,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Scattered (1 to 4 %)',
            value: 26,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody Closed (> 65 %)',
            value: 27,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody Open (40 to 65 %)',
            value: 28,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody Open (15 to 40 %)',
            value: 29,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody Sparse (4 to 15 %)',
            value: 30,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Woody Scattered (1 to 4 %)',
            value: 31,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Herbaceous Closed (> 65 %)',
            value: 32,
          },
          {
            color: '12ad2b',
            description: ' Natural Terrestrial Vegetated: Herbaceous Open (40 to 65 %)',
            value: 33,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Herbaceous Open (15 to 40 %)',
            value: 34,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Herbaceous Sparse (4 to 15 %)',
            value: 35,
          },
          {
            color: '12ad2b',
            description: 'Natural Terrestrial Vegetated: Herbaceous Scattered (1 to 4 %)',
            value: 36,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated',
            value: 55,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody',
            value: 56,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous',
            value: 57,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Closed (> 65 %)',
            value: 58,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Open (40 to 65 %)',
            value: 59,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Open (15 to 40 %)',
            value: 60,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Sparse (4 to 15 %)',
            value: 61,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Scattered (1 to 4 %)',
            value: 62,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Closed (> 65 %)',
            value: 63,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Closed (> 65 %) Water > 3 months (semi-) permanent',
            value: 64,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Closed (> 65 %) Water < 3 months (temporary or seasonal)',
            value: 65,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (40 to 65 %)',
            value: 66,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (40 to 65 %) Water > 3 months (semi-) permanent',
            value: 67,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (40 to 65 %) Water < 3 months (temporary or seasonal)',
            value: 68,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (15 to 40 %)',
            value: 69,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (15 to 40 %) Water > 3 months (semi-) permanent',
            value: 70,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Open (15 to 40 %) Water < 3 months (temporary or seasonal)',
            value: 71,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Sparse (4 to 15 %)',
            value: 72,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Sparse (4 to 15 %) Water > 3 months (semi-) permanent',
            value: 73,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Sparse (4 to 15 %) Water < 3 months (temporary or seasonal)',
            value: 74,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Scattered (1 to 4 %)',
            value: 75,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Scattered (1 to 4 %) Water > 3 months (semi-) permanent',
            value: 76,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Woody Scattered (1 to 4 %) Water < 3 months (temporary or seasonal)',
            value: 77,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Closed (> 65 %)',
            value: 78,
          },
          {
            color: 'a0d6b4',
            description: ' Natural Aquatic Vegetated: Herbaceous Closed (> 65 %) Water > 3 months (semi-) permanent',
            value: 79,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Closed (> 65 %) Water < 3 months (temporary or seasonal)',
            value: 80,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (40 to 65 %)',
            value: 81,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (40 to 65 %) Water > 3 months (semi-) permanent',
            value: 82,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (40 to 65 %) Water < 3 months (temporary or seasonal)',
            value: 83,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (15 to 40 %)',
            value: 84,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (15 to 40 %) Water > 3 months (semi-) permanent',
            value: 85,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Open (15 to 40 %) Water < 3 months (temporary or seasonal)',
            value: 86,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Sparse (4 to 15 %)',
            value: 87,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Sparse (4 to 15 %) Water > 3 months (semi-) permanent',
            value: 88,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Sparse (4 to 15 %) Water < 3 months (temporary or seasonal)',
            value: 89,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Scattered (1 to 4 %)',
            value: 90,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Scattered (1 to 4 %) Water > 3 months (semi-) permanent',
            value: 91,
          },
          {
            color: 'a0d6b4',
            description: 'Natural Aquatic Vegetated: Herbaceous Scattered (1 to 4 %) Water < 3 months (temporary or seasonal)',
            value: 92,
          },
          {
            color: 'e6e6fa',
            description: 'Artificial Surface',
            value: 93,
          },
          {
            color: '4b5320',
            description: 'Natural Surface',
            value: 94,
          },
          {
            color: '4b5320',
            description: 'Natural Surface: Sparsely vegetated',
            value: 95,
          },
          {
            color: '4b5320',
            description: 'Natural Surface: Very sparsely vegetated',
            value: 96,
          },
          {
            color: '4b5320',
            description: 'Natural Surface: Bare areas, unvegetated',
            value: 97,
          },
          {
            color: '3bb9ff',
            description: 'Water',
            value: 98,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water)',
            value: 99,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water) Tidal area',
            value: 100,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water) Perennial (> 9 months)',
            value: 101,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water) Non-perennial (7 to 9 months)',
            value: 102,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water) Non-perennial (4 to 6 months)',
            value: 103,
          },
          {
            color: '3bb9ff',
            description: 'Water: (Water) Non-perennial (1 to 3 months)',
            value: 104,
          },
        ],
      },
      {
        name: 'level4_R',
        description: |||
          R band of RGB composite for level 4 data.
        |||,
      },
      {
        name: 'level4_G',
        description: |||
          G band of RGB composite for level 4 data.
        |||,
      },
      {
        name: 'level4_B',
        description: |||
          B  band of RGB composite for level 4 data.
        |||,
      },
      {
        name: 'lifeform_veg_cat_l4a',
        description: |||
          Lifeform. Describes the detail of vegetated classes, separating woody from herbaceous.
        |||,
        'gee:classes':[
          {
            color: '808000',
            description: 'Woody (trees, shrubs)',
            value: 1,
          },
          {
            color: '848b79',
            description: 'Herbaceous (grasses, forbs)',
            value: 2,
          },
        ],
      },
      {
        name: 'waterper_wat_cat_l4d',
        description: |||
          Water Persistence. Describes the number of months a water body contains water.
        |||,
        'gee:classes':[
          {
            color: '357ec7',
            description: '> 9 months',
            value: 1,
          },
          {
            color: '6495ed',
            description: '7-9 months',
            value: 7,
          },
          {
            color: '5cb3ff',
            description: '4-6 months',
            value: 8,
          },
          {
            color: '87ceeb',
            description: '1-3 months',
            value: 9,
          },
        ],
      },
      {
        name: 'watersea_veg_cat_l4a',
        description: |||
          Water Seasonality. The length of time an aquatic vegetated area was measured as being inundated.
        |||,
        'gee:classes':[
          {
            color: '357ec7',
            description: 'Semi-permanent or permanent (> 3 months)',
            value: 1,
          },
          {
            color: '00bfff',
            description: 'Temporary or seasonal (< 3 months)',
            value: 7,
          },
        ],
      },
      {
        name: 'waterstt_wat_cat_l4a',
        description: |||
          Water State. Describes whether the detected water is snow, ice or liquid water. Only liquid water is described in this release.
        |||,
        'gee:classes':[
          {
            color: '357ec7',
            description: 'Water',
            value: 1,
          },
        ],
      },
    ],
    baregrad_phy_cat_l4d: {minimum: 0, maximum: 15, 'gee:estimated_range': false},
    canopyco_veg_cat_l4d: {minimum: 0, maximum: 16, 'gee:estimated_range': false},
    inttidal_wat_cat_l4a: {minimum: 0, maximum: 3, 'gee:estimated_range': false},
    level3: {minimum: 0, maximum: 220, 'gee:estimated_range': false},
    level3_R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    level3_G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    level3_B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    level4: {minimum: 0, maximum: 104, 'gee:estimated_range': false},
    level4_R: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    level4_G: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    level4_B: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    lifeform_veg_cat_l4a: {minimum: 0, maximum: 2, 'gee:estimated_range': false},
    waterper_wat_cat_l4d: {minimum: 0, maximum: 9, 'gee:estimated_range': false},
    watersea_veg_cat_l4a: {minimum: 0, maximum: 7, 'gee:estimated_range': false},
    waterstt_wat_cat_l4a: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'GA Landcover Level 4 RGB',
        lookat: {lon: 133.88, lat: -23.70, zoom: 5},
        image_visualization: {band_vis: {bands: ['level4_R', 'level4_G', 'level4_B']}},
      },
    ],
  },
  'sci:doi': '10.3390/data4040143',
  'sci:citation': |||
    Lucas R, Mueller N, Siggins A, Owers C, Clewley D, Bunting P, Kooymans C, Tissott B, Lewis B, Lymburner L, Metternicht G. Land Cover Mapping using Digital Earth Australia. Data. 2019; 4(4):143.
    [doi:10.3390/data4040143](https://doi.org/10.3390/data4040143).
    Christopher J. Owers, Richard M. Lucas, Daniel Clewley, Carole Planque, Suvarna Punalekar, Belle Tissott, Sean M. T. Chua, Pete Bunting, Norman Mueller & Graciela Metternicht (2021) Living Earth: Implementing national standardised land cover classification systems for Earth Observation in support of sustainable development, Big Earth Data, 5:3, 368-390.
    [doi:10.1080/20964471.2021.1948179](https://doi.org/10.1080/20964471.2021.1948179).
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
