local id = 'WorldPop/GP/100m/pop_age_sex';
local subdir = 'WorldPop';

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
  ],
  id: id,
  title:
    'WorldPop Global Project Population Data: Estimated Age and Sex ' +
    'Structures of Residential Population per 100x100m Grid Square',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Global high-resolution, contemporary data on human population distributions are
    a prerequisite for the accurate measurement of the impacts of population
    growth, for monitoring changes, and for planning interventions. The WorldPop
    project aims to meet these needs through the provision of detailed and open
    access population distribution datasets built using transparent and
    peer-reviewed approaches.

    Full details on the methods and datasets used in constructing the
    data, along with open access publications, are provided on the
    [WorldPop website](https://www.worldpop.org/). In brief, recent census-based
    population counts matched to their associated administrative units are
    disaggregated to ~100x100m grid cells through machine learning approaches
    that exploit the relationships between population densities and a range of
    geospatial covariate layers. The mapping approach
    is Random Forest-based dasymetric redistribution.

    This dataset contains breakdown of estimated population by age
    and gender groups. Currently only 2020 data are present.

    [See explanation of constrained vs unconstrained datasets](https://www.worldpop.org/methods/top_down_constrained_vs_unconstrained).

    Further WorldPop gridded datasets on population age structures,
    poverty, urban growth, and population dynamics are freely available on
    the WorldPop website. WorldPop represents a collaboration between
    researchers at the University of Southampton, Universite Libre de
    Bruxelles, and University of Louisville. The project is principally funded by
    the Bill and Melinda Gates Foundation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['population'],
  keywords: [
    'demography',
    'population',
    'worldpop',
  ],
  providers: [
    ee.producer_provider('WorldPop', 'https://www.worldpop.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'country',
        description: 'Country',
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      92.77,
    ],
    'eo:bands': [
      {
        name: 'population',
        description: 'Estimated number of people residing in each grid cell',
      },
      {
        name: 'M_0',
        description: 'Estimated number of men between 0 and 1 years old residing in each grid cell',
      },
      {
        name: 'M_1',
        description: 'Estimated number of men between 1 and 4 years old residing in each grid cell',
      },
      {
        name: 'M_5',
        description: 'Estimated number of men between 5 and 9 years old residing in each grid cell',
      },
      {
        name: 'M_10',
        description: 'Estimated number of men between 10 and 14 years old residing in each grid cell',
      },
      {
        name: 'M_15',
        description: 'Estimated number of men between 15 and 19 years old residing in each grid cell',
      },
      {
        name: 'M_20',
        description: 'Estimated number of men between 20 and 24 years old residing in each grid cell',
      },
      {
        name: 'M_25',
        description: 'Estimated number of men between 25 and 29 years old residing in each grid cell',
      },
      {
        name: 'M_30',
        description: 'Estimated number of men between 30 and 34 years old residing in each grid cell',
      },
      {
        name: 'M_35',
        description: 'Estimated number of men between 35 and 39 years old residing in each grid cell',
      },
      {
        name: 'M_40',
        description: 'Estimated number of men between 40 and 44 years old residing in each grid cell',
      },
      {
        name: 'M_45',
        description: 'Estimated number of men between 45 and 49 years old residing in each grid cell',
      },
      {
        name: 'M_50',
        description: 'Estimated number of men between 50 and 54 years old residing in each grid cell',
      },
      {
        name: 'M_55',
        description: 'Estimated number of men between 55 and 59 years old residing in each grid cell',
      },
      {
        name: 'M_60',
        description: 'Estimated number of men between 60 and 64 years old residing in each grid cell',
      },
      {
        name: 'M_65',
        description: 'Estimated number of men between 65 and 69 years old residing in each grid cell',
      },
      {
        name: 'M_70',
        description: 'Estimated number of men between 70 and 74 years old residing in each grid cell',
      },
      {
        name: 'M_75',
        description: 'Estimated number of men between 75 and 79 years old residing in each grid cell',
      },
      {
        name: 'M_80',
        description: 'Estimated number of men 80 years old or above residing in each grid cell',
      },
      {
        name: 'F_0',
        description: 'Estimated number of women between 0 and 1 years old residing in each grid cell',
      },
      {
        name: 'F_1',
        description: 'Estimated number of women between 1 and 4 years old residing in each grid cell',
      },
      {
        name: 'F_5',
        description: 'Estimated number of women between 5 and 9 years old residing in each grid cell',
      },
      {
        name: 'F_10',
        description: 'Estimated number of women between 10 and 14 years old residing in each grid cell',
      },
      {
        name: 'F_15',
        description: 'Estimated number of women between 15 and 19 years old residing in each grid cell',
      },
      {
        name: 'F_20',
        description: 'Estimated number of women between 20 and 24 years old residing in each grid cell',
      },
      {
        name: 'F_25',
        description: 'Estimated number of women between 25 and 29 years old residing in each grid cell',
      },
      {
        name: 'F_30',
        description: 'Estimated number of women between 30 and 34 years old residing in each grid cell',
      },
      {
        name: 'F_35',
        description: 'Estimated number of women between 35 and 39 years old residing in each grid cell',
      },
      {
        name: 'F_40',
        description: 'Estimated number of women between 40 and 44 years old residing in each grid cell',
      },
      {
        name: 'F_45',
        description: 'Estimated number of women between 45 and 49 years old residing in each grid cell',
      },
      {
        name: 'F_50',
        description: 'Estimated number of women between 50 and 54 years old residing in each grid cell',
      },
      {
        name: 'F_55',
        description: 'Estimated number of women between 55 and 59 years old residing in each grid cell',
      },
      {
        name: 'F_60',
        description: 'Estimated number of women between 60 and 64 years old residing in each grid cell',
      },
      {
        name: 'F_65',
        description: 'Estimated number of women between 65 and 69 years old residing in each grid cell',
      },
      {
        name: 'F_70',
        description: 'Estimated number of women between 70 and 74 years old residing in each grid cell',
      },
      {
        name: 'F_75',
        description: 'Estimated number of women between 75 and 79 years old residing in each grid cell',
      },
      {
        name: 'F_80',
        description: 'Estimated number of women 80 years old or above residing in each grid cell',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population',
        lookat: {
          lat: 34.769,
          lon: 113.643,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              50.0,
            ],
            palette: [
              '24126c',
              '1fff4f',
              'd4ff50',
            ],
            bands: [
              'population',
            ],
          },
        },
      },
    ],
    population: {
      minimum: 0.0,
      maximum: 21171.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': 'Please cite the WorldPop website as the source: [www.worldpop.org]\n(https://www.worldpop.org).',
  'sci:publications': [
    {
      citation: |||
        Americas population data: Alessandro Sorichetta, Graeme M. Hornby,
        Forrest R. Stevens, Andrea E. Gaughan, Catherine Linard, Andrew J. Tatem,
        2015, High-resolution gridded population datasets for Latin America and the
        Caribbean in 2010, 2015, and 2020, Scientific Data,
        [doi:10.1038/sdata.2015.45](https://doi.org/10.1038/sdata.2015.45)
      |||,
      doi: '10.1038/sdata.2015.45',
    },
    {
      citation: |||
        Africa population count data: Linard, C., Gilbert, M., Snow, R.W., Noor,
        A.M. and Tatem, A.J., 2012, Population distribution, settlement patterns
        and accessibility across Africa in 2010, PLoS ONE, 7(2): e31743.
      |||,
    },
    {
      citation: |||
        Asia population count data: Gaughan AE, Stevens FR, Linard C, Jia P and
        Tatem AJ, 2013, High resolution population distribution maps for Southeast
        Asia in 2010 and 2015, PLoS ONE, 8(2): e55882.
      |||,
    },
  ],
  'gee:terms_of_use': |||
    WorldPop datasets are licensed under the Creative Commons Attribution 4.0
    International License. Users are free to use, copy, distribute, transmit,
    and adapt the work for commercial and non-commercial purposes, without
    restriction, as long as clear attribution of the source is provided.
  |||,
  'gee:user_uploaded': true,
}
