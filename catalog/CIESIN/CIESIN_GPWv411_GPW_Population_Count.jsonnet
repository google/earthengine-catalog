local id = 'CIESIN/GPWv411/GPW_Population_Count';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/GPW_population_count_versions.libsonnet';

local subdir = 'CIESIN';

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
  title: 'GPWv411: Population Count (Gridded Population of the World Version 4.11)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains estimates of the number of persons per
    30 arc-second grid cell consistent with national censuses and population
    registers. There is one image for each modeled year.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-count-rev11/docs)

    Note: Because this collection has a pyramid policy of MEAN, zooming out
    results in information loss. Calculations need to be performed at native
    resolution.
  ||| + importstr 'GPWv411.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4JW8BX5',
    },
  ] + version_config.version_links,
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4JW8BX5'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1597158029-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'population_count',
        description: 'The estimated number of persons per 30 arc-second grid cell.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population Count',
        lookat: {
          lat: 19.81,
          lon: 79.1,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1000.0,
            ],
            palette: [
              'ffffe7',
              '86a192',
              '509791',
              '307296',
              '2c4484',
              '000066',
            ],
            bands: [
              'population_count',
            ],
          },
        },
      },
    ],
    population_count: {
      minimum: 0.0,
      maximum: 627597.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4JW8BX5',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4): Population Count, Revision 11. Palisades, NY: NASA Socioeconomic Data and
    Applications Center (SEDAC). [https://doi.org/10.7927/H4JW8BX5](https://doi.org/10.7927/H4JW8BX5).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 5,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
