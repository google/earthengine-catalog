local id = 'WorldPop/POP';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/pop_versions.libsonnet';

local subdir = 'WorldPop';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WorldPop Project Population Data: Estimated Residential Population per 100x100m Grid Square [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    High-resolution, contemporary data on human population distributions are
    a prerequisite for the accurate measurement of the impacts of population
    growth, for monitoring changes, and for planning interventions. The WorldPop
    project aims to meet these needs through the provision of detailed and open
    access population distribution datasets built using transparent and
    peer-reviewed approaches.

    Full details on the methods and datasets used in constructing the data,
    along with open access publications, are provided on the [WorldPop
    website](https://www.worldpop.org/). In brief, recent census-based
    population counts matched to their associated administrative units are
    disaggregated to &asymp;100x100m grid cells through machine learning
    approaches that exploit the relationships between population densities and a
    range of geospatial covariate layers. The datasets depict estimated number
    of people residing in each grid cell in 2010, 2015, and other years.

    Further WorldPop gridded datasets on population age structures,
    poverty, urban growth, and population dynamics are freely available on
    the WorldPop website. WorldPop represents a collaboration between
    researchers at the University of Southampton, Universite Libre de
    Bruxelles, and University of Louisville. The project is principally
    funded by the Bill and Melinda Gates Foundation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'demography',
    'population',
    'worldpop',
  ],
  providers: [
    ee.producer_provider('WorldPop', 'https://www.worldpop.org'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -59.94, 180.0, 54.08,
                    '2010-01-01T00:00:00Z', '2016-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'UNadj',
        description: "Unadjusted: 'yes' or 'no'",
        type: ee_const.var_type.string,
      },
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
  'sci:citation': 'Please cite the WorldPop website as the source: [www.worldpop.org]\n(www.worldpop.org).',
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
}
