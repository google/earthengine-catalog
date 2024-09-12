local id = 'CIESIN/GPWv411/GPW_Land_Area';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/CIESIN_land_area_versions.libsonnet';

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
  title: 'GPWv411: Land Area (Gridded Population of the World Version 4.11)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains the estimate of the surface area of land
    in square kilometers per pixel, excluding permanent ice and water,
    within each pixel, and was used to calculate the GPWv4 population density
    datasets.

    [General Documentation](https://beta.sedac.ciesin.columbia.edu/data/set/gpw-v4-quality-indicators/docs)
  ||| + importstr 'GPWv411.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4Z60M4Z',
    },
  ] + version_config.version_links,
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4Z60M4Z'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1597156945-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'land_area',
        description: 'Estimates for land area within each 30-arc second pixel.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Area',
        lookat: {
          lat: 19.81,
          lon: 26.4,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.86,
            ],
            palette: [
              'ecefb7',
              '745638',
            ],
            bands: [
              'land_area',
            ],
          },
        },
      },
    ],
    land_area: {
      minimum: 0.0,
      maximum: 0.86,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4Z60M4Z',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4): Land Area, Revision 11. Palisades, NY: NASA Socioeconomic Data
    and Applications Center (SEDAC). [https://doi.org/10.7927/H4Z60M4Z](https://doi.org/10.7927/H4Z60M4Z).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
