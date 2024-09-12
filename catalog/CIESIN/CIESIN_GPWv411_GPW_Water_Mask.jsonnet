local id = 'CIESIN/GPWv411/GPW_Water_Mask';
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
  title: 'GPWv411: Water Mask (Gridded Population of the World Version 4.11)',
  version: 'v4.11',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset identifies water pixels; non-water pixels are masked.
    The water mask was used to exclude areas of water and permanent ice
    from the population allocation.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-basic-demographic-characteristics-rev11/docs)
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
        name: 'water_mask',
        description: 'Water mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Identifies water pixels; non-water pixels are masked',
              bit_count: 2,
              values: [
                {
                  description: 'Total water pixels that are completely water and/or permanent ice.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Partial water pixels that also contain land.',
                },
                {
                  description: 'Total land pixels.',
                  value: 2,
                },
                {
                  value: 3,
                  description: 'Ocean pixels.',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 2,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Mask',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3.0,
            ],
            palette: [
              '005ce6',
              '00ffc5',
              'bed2ff',
              'aed0f1',
            ],
            bands: [
              'water_mask',
            ],
          },
        },
      },
    ],
    water_mask: {
      minimum: 0.0,
      maximum: 3.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H42Z13KG',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2018. Gridded Population of the World, Version 4
    (GPWv4): Water Mask, Revision 11. Palisades, NY: NASA Socioeconomic Data
    and Applications Center (SEDAC). [https://doi.org/10.7927/H42Z13KG](https://doi.org/10.7927/H42Z13KG).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
