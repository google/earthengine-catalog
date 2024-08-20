local id = 'Estonia/Maamet/orthos/mono_low_flying';
local subdir = 'Estonia';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;

local estonia_orthos = import 'Estonia_orthos.libsonnet';

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
  title: 'Estonia mono low flying orthophotos',
  'gee:type': ee_const.gee_type.image_collection,
  description: estonia_orthos.description + |||
    The mono_low_flying dataset has a single grayscale band for
    densely-populated areas.

    For more information, please see the
    [Estonia orthophotos documentation](https://geoportaal.maaamet.ee/eng/Spatial-Data/Orthophotos-p309.html)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'estonia',
    'low_flying',
    'orthophoto',
  ],
  providers: estonia_orthos.providers('', self_ee_catalog_url),
  extent: estonia_orthos.extent,
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
  'sci:citation': estonia_orthos.citation,
  'gee:terms_of_use': estonia_orthos.terms_of_use,
}
