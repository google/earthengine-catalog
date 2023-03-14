local id = 'USGS/GAP/PR/2001';
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
  title: 'USGS GAP Puerto Rico 2001',
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
  extent: ee.extent(-67.96, 17.87, -65.22, 18.53,
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
            description: 'Mature secondary lowland dry alluvial semideciduous forest',
          },
          {
            value: 2,
            description: 'Young secondary lowland dry alluvial semideciduous forest',
          },
          {
            value: 3,
            description: 'Lowland dry alluvial shrubland and woodland',
          },
          {
            value: 4,
            description: 'Mature secondary lowland dry limestone evergreen forest',
          },
          {
            value: 5,
            description: 'Mature secondary lowland dry limestone semideciduous forest',
          },
          {
            value: 6,
            description: 'Young secondary lowland dry limestone semideciduous forest',
          },
          {
            value: 7,
            description: 'Lowland dry limestone woodland and shrubland',
          },
          {
            value: 8,
            description: 'Lowland dry limestone shrubland',
          },
          {
            value: 9,
            description: 'Lowland dry cactus shrubland',
          },
          {
            value: 10,
            description: 'Coastal dwarf woodland and shrubland',
          },
          {
            value: 11,
            description: 'Lowland dry limestone cliffside semideciduous forest',
          },
          {
            value: 12,
            description: 'Lowland dry limestone cliffside shrubland and woodland',
          },
          {
            value: 13,
            description: 'Mature secondary lowland dry noncalcareous semideciduous forest',
          },
          {
            value: 14,
            description: 'Young secondary lowland dry noncalcareous semideciduous forest',
          },
          {
            value: 15,
            description: 'Lowland dry noncalcareous shrubland and woodland',
          },
          {
            value: 16,
            description: 'Mature secondary dry and moist serpentine semideciduous forest',
          },
          {
            value: 17,
            description: 'Young secondary dry and moist serpentine semideciduous forest',
          },
          {
            value: 18,
            description: 'Dry and moist serpentine woodland and shrubland',
          },
          {
            value: 19,
            description: 'Abandoned dry forest plantation',
          },
          {
            value: 20,
            description: 'Mature secondary lowland moist evergreen alluvial forest',
          },
          {
            value: 21,
            description: 'Young secondary lowland moist evergreen alluvial forest',
          },
          {
            value: 22,
            description: 'Lowland moist alluvium shrubland and woodland',
          },
          {
            value: 23,
            description: 'Mature secondary moist limestone evergreen and semideciduous forest',
          },
          {
            value: 24,
            description: 'Young secondary moist limestone evergreen and semideciduous forest',
          },
          {
            value: 25,
            description: 'Moist limestone shrubland and woodland',
          },
          {
            value: 26,
            description: 'Mature secondary lowland moist evergreen noncalcareous forest',
          },
          {
            value: 27,
            description: 'Young secondary lowland moist evergreen noncalcareous forest',
          },
          {
            value: 28,
            description: 'Lowland moist noncalcareous shrubland and woodland',
          },
          {
            value: 29,
            description: 'Lowland moist abandoned and active coffee plantations',
          },
          {
            value: 30,
            description: 'Mature secondary montane wet alluvial evergreen forest',
          },
          {
            value: 31,
            description: 'Young secondary montane wet alluvial evergreen forest',
          },
          {
            value: 32,
            description: 'Montane wet alluvial shrubland and woodland',
          },
          {
            value: 33,
            description: 'Mature secondary montane wet noncalcareous evergreen forest',
          },
          {
            value: 34,
            description: 'Mature primary and secondary montane wet noncalcareous evergreen Tabonuco forest',
          },
          {
            value: 35,
            description: 'Mature primary and secondary montane wet noncalcareous evergreen Palo Colorado cloud forest',
          },
          {
            value: 36,
            description: 'Mature primary and secondary montane wet noncalcareous evergreen Sierra Palm forest',
          },
          {
            value: 37,
            description: 'Mature primary and secondary montane wet noncalcareous evergreen elfin woodland cloud forest',
          },
          {
            value: 38,
            description: 'Young secondary montane wet noncalcareous evergreen forest',
          },
          {
            value: 39,
            description: 'Montane wet evergreen noncalcareous shrubland and woodland',
          },
          {
            value: 40,
            description: 'Mature secondary montane wet serpentine evergreen forest',
          },
          {
            value: 41,
            description: 'Young secondary montane wet serpentine evergreen forest',
          },
          {
            value: 42,
            description: 'Wet serpentine shrubland and woodland',
          },
          {
            value: 43,
            description: 'Montane wet evergreen abandoned and active coffee plantation',
          },
          {
            value: 44,
            description: 'Mangrove forest and shrubland',
          },
          {
            value: 45,
            description: 'Freshwater Pterocarpus swamp',
          },
          {
            value: 46,
            description: 'Lowland dry riparian forest',
          },
          {
            value: 47,
            description: 'Lowland dry riparian shrubland and woodland',
          },
          {
            value: 48,
            description: 'Dry grasslands and pastures',
          },
          {
            value: 49,
            description: 'Dry cactus grassland and shrubland',
          },
          {
            value: 50,
            description: 'Moist grasslands and pastures',
          },
          {
            value: 51,
            description: 'Emergent herbaceous nonsaline wetlands',
          },
          {
            value: 52,
            description: 'Emergent herbaceous saline wetlands',
          },
          {
            value: 53,
            description: 'Seasonally flooded herbaceous nonsaline wetlands',
          },
          {
            value: 54,
            description: 'Seasonally flooded herbaceous saline wetlands',
          },
          {
            value: 55,
            description: 'Hay and row crops',
          },
          {
            value: 56,
            description: 'Woody agriculture and plantations: Palm plantations',
          },
          {
            value: 57,
            description: 'Rocky cliffs and shelves',
          },
          {
            value: 58,
            description: 'Gravel beaches and stony shoreline',
          },
          {
            value: 59,
            description: 'Fine to coarse sandy beaches@ mixed sand and gravel beaches',
          },
          {
            value: 60,
            description: 'Riparian and other natural barrens',
          },
          {
            value: 61,
            description: 'Salt and mudflats',
          },
          {
            value: 62,
            description: 'Salt production',
          },
          {
            value: 63,
            description: 'High-density urban development',
          },
          {
            value: 64,
            description: 'Low-density urban development',
          },
          {
            value: 65,
            description: 'Artificial barrens',
          },
          {
            value: 66,
            description: 'Freshwater',
          },
          {
            value: 67,
            description: 'Salt water',
          },
          {
            value: 68,
            description: 'Lowland moist riparian forest',
          },
          {
            value: 69,
            description: 'Lowland moist riparian shrubland and woodland',
          },
          {
            value: 70,
            description: 'Aquaculture',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'GAP Purto Rico',
        lookat: {
          lat: 18.23,
          lon: -66.51,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              70.0,
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
      maximum: 70.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Gould, W. A. C. Alarcon, B. Fevold, M.E. Jimenez, S. Martinuzzi, G. Potts, M. Quinones,
    M. Solorzona, E. Ventosa.  2008.  The Puerto Rico Gap Analysis Project. Volume 1: Land cover,
    vertebrate species distribution, and land stewardship.  Gen. Tech. Rep. IITF-GRT-39. Rio
    Piedras, Pr.  USDA, Forest Service, International Institute of Tropical Forestery.  165. p.
  |||,
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
