local id = 'FAO/SOFO/1/TPP';
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
  title: 'Tree proximate people (TPP)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The "Tree Proximate People" (TPP) is one of the datasets contributing to the
    development of indicator #13, number of forest-dependent people in extreme
    poverty, of the Collaborative Partnership on Forests (CPF) Global Core Set
    of forest-related indicators (GCS). The TPP dataset provides 4 different
    estimates of tree proximate people (trees outside forests), all of them for
    the year 2019 with a pixel size of 100 meters at a global level.
    [Find out more about the dataset.](https://data.apps.fao.org/catalog/dcat/tree-proximate-people]
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'agriculture',
    'fao',
    'forest',
    'global',
    'population',
    'rural_area',
  ],
  providers: [
    ee.producer_provider(
      'FAO Forestry Division (TPP 500m cropland)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b8'),
    ee.producer_provider(
      'FAO Forestry Division (TPP 1km cropland)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b6'),
    ee.producer_provider(
      'FAO Forestry Division (TPP 500m agricultural)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b7'),
    ee.producer_provider(
      'FAO Forestry Division (TPP 1km agricultural)',
      'https://data.apps.fao.org/catalog/iso/8ed893bd-842a-4866-a655-a0a0c02b79b3'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2019-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      0.0009
    ],
    'eo:bands': [
      {
        name: 'TPP_1km',
        description: |||
          Number of people living in or within 1 km from agricultural lands
          with at least 10% of tree cover
        |||,
        'gee:units': 'Number of people/ha',
      },
      {
        name: 'TPP_1km_cropland',
        description: |||
          Number of people living in or within 1 km from croplands with at
          least 10% of tree cover
        |||,
        'gee:units': 'Number of people/ha',
      },
      {
        name: 'TPP_500m',
        description: |||
          Number of people living in or within 500 m from agricultural lands
          with at least 10% of tree cover
        |||,
        'gee:units': 'Number of people/ha',
      },
      {
        name: 'TPP_500m_cropland',
        description: |||
          Number of people living in or within 500 m from croplands with at
          least 10% of tree cover
        |||,
        'gee:units': 'Number of people/ha',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tree proximate people - 1km cutoff distance',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
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
              'TPP_1km',
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
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
