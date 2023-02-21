local id = 'Spain/PNOA/PNOA10';
local subdir = 'Spain';

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
  title: 'Spain RGB orthophotos 10 cm',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Mosaics of orthophotos from flights carried out between 2007 and 2018 by
    various public administration bodies at 10cm pixel resolution.
    This data is provided by National Plan for Aerial Orthophotography Spain
    ([PNOA](https://pnoa.ign.es)).

    For more information, please see the [Spain orthophotos documentation]
    (https://pnoa.ign.es/web/portal/pnoa-imagen/proceso-fotogrametrico)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'orthophoto',
    'pnoa',
    'rgb',
    'spain',
  ],
  providers: [
    ee.producer_provider(
    'Spain orthophotos',
    'https://pnoa.ign.es/web/portal/pnoa-imagen/productos-a-descarga'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(36.11, -9.32, 43.48, 4.7,
                    '2007-01-01T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      0.1,
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
      }
    ],
    'gee:visualizations': [
        {
        display_name: 'RGB',
        lookat: {
          lat: -1.85,
          lon: 38.98,
          zoom: 19,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              255
            ],
            bands: [
              'R',
              'G',
              'B',
            ],
          },
        },
      }
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
  'sci:citation': 'National Geographic Institute Spain',
  'gee:terms_of_use': |||
    The data is free and free use for any legitimate purpose,
    the only strict obligation being that of acknowledging and mentioning the
    origin and ownership of the geographic information products and services
    licensed as National Geographic Institute.

    For more details, see [Terms of use](http://www.ign.es/resources/licencia/Condiciones_licenciaUso_IGN.pdf)
  |||
}
