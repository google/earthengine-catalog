local id = 'FAO/SOFO/1/FPP';
local subdir = 'FAO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'Forest proximate people (FPP)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The "Forest Proximate People" (FPP) dataset is one of the data layers
    contributing to the development of indicator #13, "number of
    forest-dependent people in extreme poverty," of the Collaborative
    Partnership on Forests (CPF) Global Core Set of forest-related
    indicators (GCS). The FPP dataset provides an estimate of the number of
    people living in or within 1 kilometer of forests
    (forest-proximate people) for the year 2019 with a pixel size of 100 meters
    at a global level.
    [Find out more about the dataset.](https://data.apps.fao.org/catalog/dcat/forest-proximate-people)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'fao',
    'farming',
    'forestry',
    'global',
    'indicator',
    'population',
    'rural',
  ],
  providers: [
    ee.producer_provider(
      'FAO Forestry Division (FPP 1km)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b4'),
    ee.producer_provider(
      'FAO Forestry Division (FPP 5km)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b5'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      0.0009
    ],
    'eo:bands': [
      {
        name: 'FPP_1km',
        description: |||
          Number of people living in or within 1 kilometer of forests.
        |||,
        'gee:units': 'Number of people/ha',
      },
      {
        name: 'FPP_5km',
        description: |||
          Number of people living in or within 5 kilometer of forests.
        |||,
        'gee:units': 'Number of people/ha',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Forest proximate people - 1km cutoff distance',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 4,
        },
        image_visualization: {
          global_vis: {
            min: [
              0,
            ],
            max: [
              12,
            ],
            palette: [
              'blue',
              'yellow',
           'red',
            ],
            bands: [
              'FPP_1km',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    [FAO 2022. The State of the World's Forests (SOFO) - Forest pathways for green recovery and building inclusive, resilient and sustainable economies. FAO, Rome.](https://www.fao.org/documents/card/en/c/cb9360en)
  |||,
  'sci:publications': [
    {
      citation: |||
        Newton, P., Castle, S.E., Kinzer, A.T., Miller, D.C., Oldekop, J.A.,
        Linhares-Juvenal, T., Pina, L., Madrid, M., & de Lamo, J. 2022.
        The number of forest- and tree-proximate people: a new methodology
        and global estimates, One Earth, 2020
        [10.1016/j.oneear.2020.08.016](https://doi.org/10.1016/j.oneear.2020.08.016),
      |||,
      doi: '10.1016/j.oneear.2020.08.016',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': 'CC-BY-4.0',
  'gee:user_uploaded': true,
}
