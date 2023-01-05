local id = 'Finland/SMK/V/50cm';
local subdir = 'Finland';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Finland RGB NLS orthophotos 50 cm by SMK',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    NLS Orthophotos are an aerial photo dataset covering the whole of Finland.
    This data is provided by SMK([The Energy Agency](https://energiavirasto.fi/etusivu),
    formerly abbreviated SMK). An orthophoto is a combination of several
    individual aerial photos. The aerial photo data set in orthophoto format is
    available as the most recent data set consisting of the most recent aerial
    photos available. The most recent data is usually 1-3 years old. NLS
    Orthophotos are updated every 3 years (in Northern Lapland 12 years).

    (In Dataset id, V stands for "v&auml;ri", which means "color" as opposed to
    "false color")
    For more information, please see the [NLS orthophotos documentation]
    (https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/orthophotos)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'finland',
    'orthophoto',
    'rgb',
    'smk',
  ],
  providers: [
    ee.producer_provider(
    'NLS orthophotos',
    'https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/orthophotos'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(59.0, 18.0, 69.4, 29.2,
                    '2015-01-01T00:00:00Z', '2023-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      0.5,
    ],
    'eo:bands': [
      {
        name: 'R',
        description: 'Red',
      },
      {
        name: 'G',
        description: 'Green',
      },
      {
        name: 'B',
        description: 'Blue',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'RGB',
        lookat: {
          lat: 24.9,
          lon: 60.2,
          zoom: 17,
        },
        image_visualization: {
          band_vis: {
            min: [
              11.0,
            ],
            max: [
              190.0,
            ],
            bands: [
              'R',
              'G',
              'B',
            ],
          },
        },
      },
    ],
    R: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    G: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
    B: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': 'The National Land Survey of Finland',
  'gee:terms_of_use': |||
    Mention the name of the Licensor (the National Land Survey of Finland),
    the name of the dataset(s) and the time when the National Land Survey has
    delivered the dataset(s) (e.g.: contains data from the National Land Survey
    of Finland Topographic Database 06/2014).
    please see the [Terms of use](
    https://creativecommons.org/licenses/by/4.0/)
  |||,
}
