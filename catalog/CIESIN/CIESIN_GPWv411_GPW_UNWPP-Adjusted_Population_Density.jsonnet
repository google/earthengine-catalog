local id = 'CIESIN/GPWv411/GPW_UNWPP-Adjusted_Population_Density';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/GPW_adjusted_population_density_versions.libsonnet';

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
  title: 'GPWv411: UN-Adjusted Population Density (Gridded Population of the World Version 4.11)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains estimates of the number of persons
    per 30 arc-second grid cell, consistent with national censuses and
    population registers with respect to relative spatial distribution but
    adjusted to match the 2015 Revision of UN World Population Prospects
    country totals. There is one image for each modeled year.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11/docs)
  ||| + importstr 'GPWv411.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4F47M65',
    },
  ] + version_config.version_links,
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4F47M65'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1597159135-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'unwpp-adjusted_population_density',
        description: 'The estimated number of persons per square kilometer.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'UN WPP-Adjusted Population Density',
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
              'ffc869',
              'ffac1d',
              'e17735',
              'f2552c',
              '9f0c21',
            ],
            bands: [
              'unwpp-adjusted_population_density',
            ],
          },
        },
      },
    ],
    'unwpp-adjusted_population_density': {
      minimum: 0.0,
      maximum: 778120.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4F47M65',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4.11): Population Density Adjusted to Match 2015 Revision of UN WPP
    Country Totals, Revision 11. Palisades, NY: NASA Socioeconomic Data and Applications
    Center (SEDAC). [https://doi.org/10.7927/H4F47M65](https://doi.org/10.7927/H4F47M65).
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
