local id = 'JRC/GHSL/P2016/POP_GPW_GLOBE_V1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_pop_versions.libsonnet';

local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GHSL: Global Human Settlement Layers, Population Grid 1975-1990-2000-2015 (P2016) [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHSL relies on the design and implementation of new spatial data mining
    technologies allowing to automatically process and extract analytics and
    knowledge from large amount of heterogeneous data including: global,
    fine-scale satellite image data streams, census data, and crowd sources or
    volunteered geographic information sources.

    This dataset depicts the distribution and density of population, expressed
    as the number of people per cell, for reference epochs: 1975, 1990, 2000,
    2015.

    Residential population estimates were provided by CIESIN GPW v4. These were
    disaggregated from census or administrative units to grid cells, informed by
    the distribution and density of built-up as mapped in the GHSL global layer
    per corresponding epoch. (See ["Development of New Open and Free
    Multi-temporal Global Population Grids at 250 m
    Resolution."](https://publications.jrc.ec.europa.eu/repository/handle/JRC100523))

    This dataset was produced in the World Mollweide projection (EPSG:54009).

    For more information visit: [https://ghsl.jrc.ec.europa.eu/ghs_pop.php](https://ghsl.jrc.ec.europa.eu/ghs_pop.php).

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy. The GHSL produces new global spatial information,
    evidence-based analytics, and knowledge describing the human presence in
    the planet.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'ciesin_derived',
    'ghsl',
    'jrc',
    'population',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/index.php'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2015-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'population_count',
        description: 'Number of people per cell',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population Count',
        lookat: {
          lat: 22.59,
          lon: 78.22,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              200.0,
            ],
            palette: [
              '060606',
              '337663',
              '337663',
              'ffffff',
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
      maximum: 1344190.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    European Commission, Joint Research Centre (JRC); Columbia University,
    Center for International Earth Science Information Network - CIESIN (2015):
    GHS population grid, derived from GPW4, multitemporal (1975, 1990, 2000,
    2015). European Commission, Joint Research Centre (JRC) [Dataset]
    PID: [https://data.europa.eu/89h/jrc-ghsl-ghs_pop_gpw4_globe_r2015a](https://data.europa.eu/89h/jrc-ghsl-ghs_pop_gpw4_globe_r2015a)
  |||,
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
  'gee:user_uploaded': true,
}
