local id = 'NASA/EMIT/L2B/CH4PLM';
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
  title: 'Earth Surface Mineral Dust Source Investigation- Methane Plume Complexes',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + |||
     The EMIT Level 2B Estimated Methane Plume Complexes (EMITL2BCH4PLM) Version
     1 data product provides estimated methane plume complexes in parts per
     million meter (ppm m) along with uncertainty data. The EMITL2BCH4PLM data
     product will only be generated where methane plume complexes have been
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
        name: 'global_plume_identifier',
        description: 'Global Plume Identification Number',
        type: ee_const.var_type.string,
      },
      {
        name: 'Concentration_Uncertainty',
        description: 'Uncertainity in Concentration',
        type: ee_const.var_type.double,
      },
      {
        name: 'DAAC_Scene_Names',
        description: 'DAAC Scene Names',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'DAAC_Scene_Numbers',
        description: 'DAAC Scene Numbers',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'DCID',
        description: 'Data Collection Identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'Latitude_of_max_concentration',
        description: 'Latitute with maximum concentration',
        type: ee_const.var_type.double,
      },
      {
        name: 'Longitude_of_max_concentration',
        description: 'Longitude with maximum concentration',
        type: ee_const.var_type.double,
      },
      {
        name: 'Max_Plume_Concentration',
        description: 'Maximum Plume Concentration',
        type: ee_const.var_type.double,
      },
      {
        name: 'Orbit',
        description: 'Unique orbit number',
        type: ee_const.var_type.string,
      },
      {
        name: 'Plume_ID',
        description: 'Unique Plume Identification number',
        type: ee_const.var_type.string,
      },
      {
        name: 'Scene_FIDs',
        description: 'Scene FIDs',
        type: ee_const.var_type.string_list,
      },
    ],
    gsd: [
      72000.0,
    ],
    'eo:bands': [
      {
        name: 'methane_plume_complex',
        description: 'Estimated Methane plume complex.',
        'gee:units': units.ppmm,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Emit Plume Complex',
        lookat: {
          lon: 53.99,
          lat: 39.11,
          zoom: 8,
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
              'methane_plume_complex',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/EMIT/EMITL2BCH4PLM.001',
  'sci:citation': |||
    Green, R., Thorpe, A., Brodrick, P., Chadwick, D., Elder, C.,
    Villanueva-Weeks, C., Fahlen, J., Coleman, R., Jensen, D., Olsen-Duvall, W.,
    Lundeen, S., Lopez, A., Thompson, D. (2023). EMIT L2B Estimated Methane
    Plume Complexes 60 m V001 [Data set]. NASA EOSDIS Land Processes Distributed
    Active Archive Center. Accessed 2024-03-06 from
    [https://doi.org/10.5067/EMIT/EMITL2BCH4PLM.001](https://doi.org/10.5067/EMIT/EMITL2BCH4PLM.001)
  |||,
  'gee:interval': template.interval,
  'gee:terms_of_use': template.gee_terms_of_use
}
