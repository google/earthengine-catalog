local id = 'WorldPop/GP/100m/R2025A/v1/pop';
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
  title: 'WorldPop Global Project Population Data (R2025A): Estimated Residential Population per 100x100m Grid Square',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The WorldPop project aims to provide detailed and open-access population
    distribution datasets, built using transparent and peer-reviewed approaches,
    to facilitate the accurate measurement of the impacts of population growth,
    for monitoring changes, and for planning interventions.

    Full details on the methods and datasets used in constructing the
    data, along with open access publications, are provided on the
    [WorldPop website](https://www.worldpop.org/). In brief, recent census-based
    population counts matched to their associated administrative units are
    disaggregated to ~100x100m grid cells through machine learning approaches
    that exploit the relationships between population densities and a range of
    geospatial covariate layers. The mapping approach
    is Random Forest-based dasymetric redistribution.

    This dataset depicts estimated number of people
    residing in each grid cell for annual epochs from 2015 through 2030 (Release R2025A, v1).
    Individual country rasters are constrained to settlement areas and adjusted to
    match national population estimates.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': ['population'],
  keywords: [
    'demography',
    'population',
    'worldpop',
  ],
  providers: [
    ee.producer_provider('WorldPop', 'https://www.worldpop.org'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2015-01-01T00:00:00Z', '2031-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'country',
        description: 'ISO 3166-1 alpha-3 country code, with optional _EAST / _WEST suffix for territories split by the antimeridian.',
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Year of the population estimate (2015-2030)',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      100.0,
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
      maximum: 25000.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5258/SOTON/WP00839',
  'sci:citation': |||
    Bondarenko M., Priyatikanto R., Tejedor-Garavito N., Zhang W., McKeen T., Cunningham A.,
    Woods T., Hilton J., Cihan D., Nosatiuk B., Brinkhoff T., Tatem A., Sorichetta A. 2025.
    Constrained estimates of 2015-2030 total number of people per grid square at a resolution of 3 arc
    (approximately 100m at the equator) R2025A version v1. Global Demographic Data Project - Funded by
    The Bill and Melinda Gates Foundation (INV-045237). WorldPop - School of Geography and Environmental
    Science, University of Southampton.
    [doi:10.5258/SOTON/WP00839](https://doi.org/10.5258/SOTON/WP00839)
  |||,
  'gee:terms_of_use': |||
    WorldPop datasets are licensed under the Creative Commons Attribution 4.0
    International License. Users are free to use, copy, distribute, transmit,
    and adapt the work for commercial and non-commercial purposes, without
    restriction, as long as clear attribution of the source is provided.
  |||,
}
