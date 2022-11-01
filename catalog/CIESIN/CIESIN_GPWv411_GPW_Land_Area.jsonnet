local id = 'CIESIN/GPWv411/GPW_Land_Area';
local subdir = 'CIESIN';

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
  title: 'GPWv411: Land Area (Gridded Population of the World Version 4.11)',
  version: 'v4.11',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Gridded Population of World Version 4 (GPWv4), Revision 11 models the distribution
    of global human population for the years 2000, 2005, 2010, 2015, and 2020
    on 30 arc-second (approximately 1km) grid cells. Population is distributed
    to cells using proportional allocation of population from census and
    administrative units. Population input data are collected at the most
    detailed spatial resolution available from the results of the 2010 round of
    censuses, which occurred between 2005 and 2014. The input data are
    extrapolated to produce population estimates for each modeled year.

    This data grids contains per-pixel data containing land surface area estimates.

    [General Documentation](https://beta.sedac.ciesin.columbia.edu/data/set/gpw-v4-quality-indicators/docs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4Z60M4Z',
    },
  ],
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4Z60M4Z'),
    ee.host_provider(self_ee_catalog_url),
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
