local id = 'CIESIN/GPWv411/GPW_Data_Context';
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
  title: 'GPWv411: Data Context (Gridded Population of the World Version 4.11)',
  version: 'v4.11',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset categorizes pixels with estimated zero population based on
    information provided in the census documents.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-admin-unit-center-points-population-estimates-rev11/docs)
  ||| + importstr 'GPWv411.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H42Z13KG',
    },
  ],
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H42Z13KG'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1597149689-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'data_context',
        description: |||
          Categorizes pixels with estimated zero population based on
          information provided in the census documents.
        |||,
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Not Applicable',
            value: 0,
          },
          {
            value: 201,
            color: '099506',
            description: 'Park or protected area',
          },
          {
            value: 202,
            color: 'f04923',
            description: 'Military district, airport zone, or other infrastructure',
          },
          {
            value: 203,
            color: 'e62440',
            description: 'Not enumerated or not reported in census',
          },
          {
            value: 204,
            color: '706984',
            description: 'No households',
          },
          {
            value: 205,
            color: 'a5a5a5',
            description: 'Uninhabited',
          },
          {
            value: 206,
            color: 'd4cc11',
            description: 'Population not gridded',
          },
          {
            value: 207,
            color: '000000',
            description: 'Missing age or sex data',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Data Context',
        lookat: {
          lat: -84.6,
          lon: 26.4,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              200.0,
            ],
            max: [
              207.0,
            ],
            palette: [
              'ffffff',
              '099506',
              'f04923',
              'e62440',
              '706984',
              'a5a5a5',
              'ffe152',
              'd4cc11',
              '000000',
            ],
            bands: [
              'data_context',
            ],
          },
        },
      },
    ],
    data_context: {
      minimum: 0.0,
      maximum: 207.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H42Z13KG',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4): Data Context, Revision 11. Palisades, NY: NASA Socioeconomic Data
    and Applications Center (SEDAC). [doi:10.7927/H46M34XX](https://doi.org/10.7927/H46M34XX).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
