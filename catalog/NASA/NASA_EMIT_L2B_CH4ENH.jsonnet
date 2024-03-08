local id = 'NASA/EMIT/L2B/CH4ENH';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local template = import 'NASA_EMIT_L2B.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Earth Surface Mineral Dust Source Investigation- Methane Enhancement',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + |||
     The EMIT Level 2B Methane Enhancement Data (EMITL2BCH4ENH) Version 1 data
     product is a total vertical column enhancement estimate of methane in parts
     per million meter (ppm m) based on an adaptive matched filter approach.
     EMITL2BCH4ENH provides per-pixel methane enhancement data used to identify
     methane plume complexes. The initial release of the EMITL2BCH4ENH data
     product will only include granules where methane plume complexes have been
     identified.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'daily',
    'emit',
    'nasa',
    'methane',
  ],
  providers: [
    ee.producer_provider('NASA Jet Propulsion Laboratory', 'https://earth.jpl.nasa.gov/emit/data/data-products/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-08-10T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'orbit_identification_number',
        description: 'Unique Orbit Identification Number',
        type: ee_const.var_type.string,
      },
      {
        name: 'scene_identification_number',
        description: 'Unique scene identification nuber',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      72000.0,
    ],
    'eo:bands': [
      {
        name: 'vertical_column_enhancement',
        description: |||
          Total vertical column enhancement estimate of methane
        |||,
        'gee:units': units.ppmm,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Emit Enhancement',
        lookat: {
          lon: -100.24,
          lat: 32.04,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              100.0,
            ],
            bands: [
              'vertical_column_enhancement',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/EMIT/EMITL2BCH4ENH.001',
  'sci:citation': |||
    Green, R., Thorpe, A., Brodrick, P., Chadwick, D., Elder, C.,
    Villanueva-Weeks, C., Fahlen, J., Coleman, R., Jensen, D., Olsen-Duvall, W.,
    Lundeen, S., Lopez, A., Thompson, D. (2023). EMIT L2B Methane Enhancement
    Data 60 m V001 [Data set]. NASA EOSDIS Land Processes Distributed Active
    Archive Center. Accessed 2024-02-26 from
    [https://doi.org/10.5067/EMIT/EMITL2BCH4ENH.001](https://doi.org/10.5067/EMIT/EMITL2BCH4ENH.001)
  |||,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.gee_terms_of_use
}
