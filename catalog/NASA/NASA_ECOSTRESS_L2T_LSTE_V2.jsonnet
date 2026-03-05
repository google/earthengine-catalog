local id = 'NASA/ECOSTRESS/L2T_LSTE/V2';
local subdir = 'NASA';
local version = 'V002';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
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
  title: 'ECOSTRESS Land Surface Temperature and Emissivity L2 Global 70 m V002',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  # TODO(aprajitaa): Update gee:status to public once expanded to all of global.
  'gee:status': 'beta',
  description: |||
    The ECOSTRESS Land Surface Temperature and Emissivity (ECO_L2T_LSTE) V002
    dataset provides Land Surface Temperature (LST), LST error, Quality Control
    flags, Broadband Emissivity, cloud mask, surface height, water mask, and
    view zenith angle data at a 70m spatial resolution. This product is derived
    from ECOSTRESS observations and is essential for understanding surface energy
    balance and water stress.

    NOTE: Currently, only tiles covering the Los Angeles metro area have been
    ingested into Earth Engine. We plan to expand coverage in the future.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1655/ECO_L1C-4_Grid_Tile_User_Guide_V2.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1869/ECOSTRESSL3JET_ATBD_V1.pdf)

    * [General Documentation](https://github.com/nasa/ECOSTRESS-Data-Resources)

    * [Land Processes Distributed Active Archive Center](https://www.earthdata.nasa.gov/centers/lp-daac)

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/ECOSTRESS/ECO_L2T_LSTE.002',
    },
  ],
  'gee:categories': ['plant-productivity'],
  keywords: [
    'land',
    'ecostress',
    'lst',
    'temperature',
    'emissivity',
  ],
  providers: [
    ee.producer_provider('Land Processes Distributed Active Archive Center', 'https://www.earthdata.nasa.gov/data/catalog/lpcloud-eco-l2t-lste-002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2076090826-LPCLOUD',
  ],
  extent: ee.extent_global('2018-07-09T00:00:00Z', null),
  summaries: {
    gsd: [
      70.0,
    ],
    'eo:bands': [
      {
        name: 'LST',
        description: 'Land Surface Temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'LST_err',
        description: 'Land Surface Temperature error',
        'gee:units': units.kelvin,
      },
      {
        name: 'QC',
        description: 'Quality Control flags for LST and emissivity',
        'gee:bitmask': {
          'bitmask_parts': [
            {
              description: 'LST Quality',
              bit_count: 1,
              first_bit: 0,
              values: [
                { value: 0, description: 'Good Quality' },
                { value: 1, description: 'Degraded Quality' },
              ],
            },
            {
              description: 'LST Error Estimate',
              bit_count: 1,
              first_bit: 1,
              values: [
                { value: 0, description: 'Good' },
                { value: 1, description: 'Degraded' },
              ],
            },
            {
              description: 'LST Temporal Interpolation',
              bit_count: 1,
              first_bit: 2,
              values: [
                { value: 0, description: 'No' },
                { value: 1, description: 'Yes' },
              ],
            },
            {
              description: 'Sky Condition',
              bit_count: 1,
              first_bit: 3,
              values: [
                { value: 0, description: 'Clear Sky' },
                { value: 1, description: 'Cloudy Sky' },
              ],
            },
            {
              description: 'LST Outlier',
              bit_count: 1,
              first_bit: 4,
              values: [
                { value: 0, description: 'No' },
                { value: 1, description: 'Yes' },
              ],
            },
            {
              description: 'Slope Consistency',
              bit_count: 1,
              first_bit: 5,
              values: [
                { value: 0, description: 'Consistent' },
                { value: 1, description: 'Inconsistent' },
              ],
            },
            {
              description: 'Snow/Ice',
              bit_count: 1,
              first_bit: 6,
              values: [
                { value: 0, description: 'No' },
                { value: 1, description: 'Yes' },
              ],
            },
            {
              description: 'Land/Water',
              bit_count: 1,
              first_bit: 7,
              values: [
                { value: 0, description: 'Land' },
                { value: 1, description: 'Water' },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'EmisWB',
        description: 'Wide band Emissivity',
      },
      {
        name: 'cloud',
        description: 'Cloud mask',
        'gee:bitmask': {
          'bitmask_parts': [
            {
              description: 'Clear',
              bit_count: 1,
              first_bit: 0,
              values: [
                { value: 0, description: 'Clear' },
                { value: 1, description: 'Cloud' },
              ],
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'height',
        description: 'Surface elevation of observation"',
        'gee:units': units.meter,
      },
      {
        name: 'water',
        description: 'Water mask',
        'gee:bitmask': {
          'bitmask_parts': [
            {
              description: 'Land/Water',
              bit_count: 1,
              first_bit: 0,
              values: [
                { value: 0, description: 'Not water' },
                { value: 1, description: 'Water' },
              ],
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'view_zenith',
        description: 'View Zenith Angle',
        'gee:units': units.degree,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Land Surface Temperature',
        lookat: {
          lat: 38.8904,
          lon: -77.1056,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              273.15,
            ],
            max: [
              323.15,
            ],
            palette: [
              '00008B', '0000FF', '00FFFF', '00FF00',
              'FFFF00', 'FF0000', '8B0000',
            ],
            bands: [
              'LST',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/ECOSTRESS/ECO_L2T_LSTE.002',
  'sci:citation': |||
    Hook, Simon, et al. ECOSTRESS Land Surface Temperature and Emissivity L2 Global 70 m
    v002. NASA Land Processes Distributed Active Archive Center, 2023,
    doi:[10.5067/ECOSTRESS/ECO_L2T_LSTE.002](https://doi.org/10.5067/ECOSTRESS/ECO_L2T_LSTE.002)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
