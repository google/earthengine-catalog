local id = 'projects/nature-trace/assets/mapl_emit_plumes_v3';
local subdir = 'nature-trace';

local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
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
  title: 'MAPL-EMIT Methane Plumes',
  version: '3',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Methane Analysis and Plume Localization with EMIT (MAPL-EMIT) is an end-to-end
    vision transformer framework that leverages the complete radiance spectrum from
    the Earth Surface Mineral Dust Source Investigation (EMIT) instrument to jointly
    retrieve methane enhancements across all pixels within a scene and detect methane
    plumes while pin-pointing their likely source locations.

    This dataset contains the model predicted outputs for methane plume complexes,
    including enhancements, plume instance masks and plume source locations.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  'gee:categories': ['atmosphere'],
  keywords: [
    'emit',
    'methane',
    'ghg',
  ],
  providers: [
    ee.producer_provider('Google Research', 'https://research.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-08-10T00:00:00Z', null),
  summaries: {
    gsd: [
      60.0,
    ],
    'eo:bands': [
      {
        name: 'B0',
        description: 'Methane enhancement (ppm-m)',
        'gee:units': units.ppmm,
      },
      {
        name: 'B1',
        description: 'Plume probability',
      },
      {
        name: 'B2',
        description: 'Origin probability',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Methane plume enhancement (ppm-m)',
        lookat: {
          lon: -101.93,
          lat: 32.28,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              300.0,
            ],
            bands: [
              'B0',
            ],
            palette: ['000004', '1b0c41', '4a0c6b', '781c6d', 'a52c60', 'cf4446', 'ed6925', 'fb9b06', 'f7d13d', 'fcffa4'],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Batchu, V. V., Conserva, M., Wilson, A., Gulshan, V., Michalak, A. M., Brodrick, P. G.,
    Thorpe, A. K., Arsdale, C. V. (2026). Global monitoring of methane point sources
    using deep learning on hyperspectral radiance measurements from EMIT.
  |||,
  'gee:terms_of_use': |||
    This dataset is provided for experimental use.
  |||
}
