local id = 'CIESIN/GPWv411/GPW_National_Identifier_Grid';
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
  title: 'GPWv411: National Identifier Grid (Gridded Population of the World Version 4.11)',
  version: 'v4.11',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset represents the Census data source used to produce
    the GPWv4 populations estimates. Pixels that have the same value reflect the same
    data source, most often a country or territory.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-national-identifier-grid-rev11/docs)
  ||| + importstr 'GPWv411.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4TD9VDP',
    },
  ],
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H4TD9VDP'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1597157684-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'national_identifier_grid',
        description: |||
          An integer that represents the census data source used
          to produce the GPWv4.11 population estimates. Pixels (grid cells) that have
          the same value reflect the same data source, most often a country or
          territory. Note that these data represent the area covered by the
          statistical data as provided, and are not official representations of
          country or territory boundaries.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'National Identifier',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              4.0,
            ],
            max: [
              999.0,
            ],
            palette: [
              'ffffff',
              '000000',
            ],
            bands: [
              'national_identifier_grid',
            ],
          },
        },
      },
    ],
    national_identifier_grid: {
      minimum: 4.0,
      maximum: 999.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4TD9VDP',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4): National Identifier Grid, Revision 11. Palisades, NY: NASA Socioeconomic Data
    and Applications Center (SEDAC). [https://doi.org/10.7927/H4F47M2C](https://doi.org/10.7927/H4F47M2C).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
