local id = 'FAO/WAPOR/2/L1_E_D';
local subdir = 'FAO';

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
  title: 'WAPOR Dekadal Evaporation',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The evaporation (E) data component (dekadal, in mm/day) is the actual evaporation of
    the soil surface. The value of each pixel represents the average daily actual
    evaporation for that specific dekad.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'agriculture',
    'fao',
    'wapor',
    'water',
  ],
  providers: [
    ee.producer_provider('FAO UN', 'https://wapor.apps.fao.org/catalog/WAPOR_2/1/L1_E_D'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-30.0044643, -40.0044644, 65.0044644, 40.0044643,
                    '2009-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      248.2,
    ],
    'eo:bands': [
      {
        name: 'L1_E_D',
        description: 'Evaporation (Dekadal) [mm]',
        'gee:units': 'mm',
        'gee:scale': 0.1,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Evaporation (Dekadal) [mm]',
        lookat: {
          lat: 20.0,
          lon: 17.5,
          zoom: 3,
        },
        image_visualization: {
          global_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    FAO 2018. WaPOR Database Methodology: Level 1. Remote Sensing for Water Productivity
    Technical Report: Methodology Series. Rome, FAO. 72 pages.
  |||,
  'sci:publications': [
    {
      citation: |||
        FAO 2020. WaPOR V2 Database Methodology. Remote Sensing for Water Productivity
        Technical Report: Methodology Series. Rome, FAO. (in press)
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 10,
  },
  'gee:terms_of_use': |||
    The Food and Agriculture Organization of the United Nations (FAO) is mandated to
    collect, analyze, interpret, and disseminate information related to nutrition,
    food, and agriculture. In this regard, it publishes a number of databases on topics
    related to FAO's mandate, and encourages the use of them for scientific and research purposes.
    Consistent with the principles of openness and sharing envisioned under the [Open Data Licensing
    For Statistical Databases](http://www.fao.org/3/ca7570en/ca7570en.pdf), and consistent with the mandate of FAO, data from the [Water
    Productivity Open Access Portal (WaPOR)](https://wapor.apps.fao.org/home/WAPOR_2/1), as part of [AQUASTAT](http://www.fao.org/aquastat/en/)
    - FAO's Global Information System on Water and Agriculture, is available free to the user community.
  |||,
  'gee:user_uploaded': true,
}
