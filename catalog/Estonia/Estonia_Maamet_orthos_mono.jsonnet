local id = 'Estonia/Maamet/orthos/mono';
local subdir = 'Estonia';

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
  title: 'Estonia mono orthophotos',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Orthophotos are an aerial photo dataset covering Estonia.

    An orthophoto is a processed aerial photo from which distortions caused
    by terrain relief, camera tilt relative to the ground at the moment of
    exposure and camera central projection are removed. A digital orthophoto
    has a certain pixel size or resolution which shows the smallest
    indivisible exposed area on the ground (Ground Sampling Distance, GSD).

    Orthophotos have a nationwide coverage and correspond to the scale of
    1:5000-1:10000 (pixel size 20-40 cm). Orthophotos for densely populated
    areas are produced with the pixel size of 10-16 cm.

    The mono dataset has a single grayscale band.

    For more information, please see the [Estonia orthophotos documentation]
    (https://geoportaal.maaamet.ee/eng/Spatial-Data/Orthophotos-p309.html)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'estonia',
    'orthophoto',
  ],
  providers: [
    ee.producer_provider(
    'Estonia orthophotos',
    'https://geoportaal.maaamet.ee/eng/Spatial-Data/Orthophotos-p309.html'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(57.3, 21.5, 59.5, 28.1,
                    '1993-01-01T00:00:00Z', '2021-06-16T00:00:00Z'),

  summaries: {
    gsd: [
      0.4,
    ],
    'eo:bands': [
      {
        name: 'mono',
        description: 'Grayscale',
      }
    ],
    'gee:visualizations': [
        {
        display_name: 'mono',
        lookat: {
          lat: 24.959,
          lon: 58.148,
          zoom: 18,
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
              'mono'
            ],
          },
        },
      },
    ],
    mono: {
      minimum: 0.0,
      maximum: 255.0,
      'gee:estimated_range': false,
    }
  },
  'sci:citation': 'Map data: Estonian Land Board',
  'gee:terms_of_use': |||
    The data is free to use for commercial and non-commercial purposes for a
    non-specified term, provided that proper attribution is given to the
    licensor (e.g. Estonian Land Board) along with the title and age of the
    data.

    For more details please see the
    [Terms of use](https://geoportaal.maaamet.ee/docs/Avaandmed/Licence-of-open-data-of-Estonian-Land-Board.pdf)
  |||
}
