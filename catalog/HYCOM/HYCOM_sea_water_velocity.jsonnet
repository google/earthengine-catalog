local id = 'HYCOM/sea_water_velocity';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/sea_water_velocity_versions.libsonnet';

local subdir = 'HYCOM';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'HYCOM.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'HYCOM: Hybrid Coordinate Ocean Model, Water Velocity',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'hycom',
    'nopp',
    'ocean',
    'velocity',
    'water',
  ],
  providers: [
    ee.producer_provider('NOPP', 'https://hycom.org/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -80.48, 180.0, 80.48, '1992-10-02T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'experiment',
        description: 'Experiment number',
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      8905.6,
    ],
    'eo:bands': [
      {
        name: 'velocity_u_0',
        description: 'Eastward sea water velocity at a depth of 0m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_0',
        description: 'Northward sea water velocity at a depth of 0m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_2',
        description: 'Eastward sea water velocity at a depth of 2m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_2',
        description: 'Northward sea water velocity at a depth of 2m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_4',
        description: 'Eastward sea water velocity at a depth of 4m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_4',
        description: 'Northward sea water velocity at a depth of 4m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_6',
        description: 'Eastward sea water velocity at a depth of 6m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_6',
        description: 'Northward sea water velocity at a depth of 6m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_8',
        description: 'Eastward sea water velocity at a depth of 8m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_8',
        description: 'Northward sea water velocity at a depth of 8m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_10',
        description: 'Eastward sea water velocity at a depth of 10m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_10',
        description: 'Northward sea water velocity at a depth of 10m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_12',
        description: 'Eastward sea water velocity at a depth of 12m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_12',
        description: 'Northward sea water velocity at a depth of 12m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_15',
        description: 'Eastward sea water velocity at a depth of 15m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_15',
        description: 'Northward sea water velocity at a depth of 15m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_20',
        description: 'Eastward sea water velocity at a depth of 20m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_20',
        description: 'Northward sea water velocity at a depth of 20m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_25',
        description: 'Eastward sea water velocity at a depth of 25m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_25',
        description: 'Northward sea water velocity at a depth of 25m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_30',
        description: 'Eastward sea water velocity at a depth of 30m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_30',
        description: 'Northward sea water velocity at a depth of 30m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_35',
        description: 'Eastward sea water velocity at a depth of 35m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_35',
        description: 'Northward sea water velocity at a depth of 35m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_40',
        description: 'Eastward sea water velocity at a depth of 40m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_40',
        description: 'Northward sea water velocity at a depth of 40m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_45',
        description: 'Eastward sea water velocity at a depth of 45m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_45',
        description: 'Northward sea water velocity at a depth of 45m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_50',
        description: 'Eastward sea water velocity at a depth of 50m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_50',
        description: 'Northward sea water velocity at a depth of 50m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_60',
        description: 'Eastward sea water velocity at a depth of 60m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_60',
        description: 'Northward sea water velocity at a depth of 60m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_70',
        description: 'Eastward sea water velocity at a depth of 70m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_70',
        description: 'Northward sea water velocity at a depth of 70m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_80',
        description: 'Eastward sea water velocity at a depth of 80m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_80',
        description: 'Northward sea water velocity at a depth of 80m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_90',
        description: 'Eastward sea water velocity at a depth of 90m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_90',
        description: 'Northward sea water velocity at a depth of 90m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_100',
        description: 'Eastward sea water velocity at a depth of 100m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_100',
        description: 'Northward sea water velocity at a depth of 100m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_125',
        description: 'Eastward sea water velocity at a depth of 125m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_125',
        description: 'Northward sea water velocity at a depth of 125m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_150',
        description: 'Eastward sea water velocity at a depth of 150m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_150',
        description: 'Northward sea water velocity at a depth of 150m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_200',
        description: 'Eastward sea water velocity at a depth of 200m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_200',
        description: 'Northward sea water velocity at a depth of 200m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_250',
        description: 'Eastward sea water velocity at a depth of 250m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_250',
        description: 'Northward sea water velocity at a depth of 250m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_300',
        description: 'Eastward sea water velocity at a depth of 300m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_300',
        description: 'Northward sea water velocity at a depth of 300m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_350',
        description: 'Eastward sea water velocity at a depth of 350m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_350',
        description: 'Northward sea water velocity at a depth of 350m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_400',
        description: 'Eastward sea water velocity at a depth of 400m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_400',
        description: 'Northward sea water velocity at a depth of 400m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_500',
        description: 'Eastward sea water velocity at a depth of 500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_500',
        description: 'Northward sea water velocity at a depth of 500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_600',
        description: 'Eastward sea water velocity at a depth of 600m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_600',
        description: 'Northward sea water velocity at a depth of 600m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_700',
        description: 'Eastward sea water velocity at a depth of 700m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_700',
        description: 'Northward sea water velocity at a depth of 700m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_800',
        description: 'Eastward sea water velocity at a depth of 800m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_800',
        description: 'Northward sea water velocity at a depth of 800m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_900',
        description: 'Eastward sea water velocity at a depth of 900m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_900',
        description: 'Northward sea water velocity at a depth of 900m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_1000',
        description: 'Eastward sea water velocity at a depth of 1000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_1000',
        description: 'Northward sea water velocity at a depth of 1000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_1250',
        description: 'Eastward sea water velocity at a depth of 1250m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_1250',
        description: 'Northward sea water velocity at a depth of 1250m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_1500',
        description: 'Eastward sea water velocity at a depth of 1500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_1500',
        description: 'Northward sea water velocity at a depth of 1500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_2000',
        description: 'Eastward sea water velocity at a depth of 2000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_2000',
        description: 'Northward sea water velocity at a depth of 2000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_2500',
        description: 'Eastward sea water velocity at a depth of 2500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_2500',
        description: 'Northward sea water velocity at a depth of 2500m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_3000',
        description: 'Eastward sea water velocity at a depth of 3000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_3000',
        description: 'Northward sea water velocity at a depth of 3000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_4000',
        description: 'Eastward sea water velocity at a depth of 4000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_4000',
        description: 'Northward sea water velocity at a depth of 4000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_u_5000',
        description: 'Eastward sea water velocity at a depth of 5000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
      {
        name: 'velocity_v_5000',
        description: 'Northward sea water velocity at a depth of 5000m',
        'gee:units': units.velocity_si,
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Velocity',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1000.0,
            ],
            max: [
              4000.0,
            ],
            bands: [
              'velocity_u_0',
              'velocity_v_0',
              'velocity_v_0',
            ],
          },
        },
      },
    ],
    velocity_u_0: {
      minimum: -31557.0,
      maximum: 16899.0,
      'gee:estimated_range': true,
    },
    velocity_v_0: {
      minimum: -20004.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_2: {
      minimum: -31588.0,
      maximum: 16806.0,
      'gee:estimated_range': true,
    },
    velocity_v_2: {
      minimum: -20000.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_4: {
      minimum: -31589.0,
      maximum: 16831.0,
      'gee:estimated_range': true,
    },
    velocity_v_4: {
      minimum: -20000.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_6: {
      minimum: -31589.0,
      maximum: 16794.0,
      'gee:estimated_range': true,
    },
    velocity_v_6: {
      minimum: -19991.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_8: {
      minimum: -31575.0,
      maximum: 16828.0,
      'gee:estimated_range': true,
    },
    velocity_v_8: {
      minimum: -19792.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_10: {
      minimum: -31563.0,
      maximum: 16828.0,
      'gee:estimated_range': true,
    },
    velocity_v_10: {
      minimum: -19582.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_12: {
      minimum: -31547.0,
      maximum: 16828.0,
      'gee:estimated_range': true,
    },
    velocity_v_12: {
      minimum: -19582.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_15: {
      minimum: -31517.0,
      maximum: 16828.0,
      'gee:estimated_range': true,
    },
    velocity_v_15: {
      minimum: -19582.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_20: {
      minimum: -32768.0,
      maximum: 16743.0,
      'gee:estimated_range': true,
    },
    velocity_v_20: {
      minimum: -18593.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_25: {
      minimum: -32768.0,
      maximum: 16370.0,
      'gee:estimated_range': true,
    },
    velocity_v_25: {
      minimum: -18131.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_30: {
      minimum: -32768.0,
      maximum: 15996.0,
      'gee:estimated_range': true,
    },
    velocity_v_30: {
      minimum: -17489.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_35: {
      minimum: -32768.0,
      maximum: 15639.0,
      'gee:estimated_range': true,
    },
    velocity_v_35: {
      minimum: -17409.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_40: {
      minimum: -32768.0,
      maximum: 15120.0,
      'gee:estimated_range': true,
    },
    velocity_v_40: {
      minimum: -17386.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_45: {
      minimum: -32768.0,
      maximum: 15066.0,
      'gee:estimated_range': true,
    },
    velocity_v_45: {
      minimum: -17302.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_50: {
      minimum: -32768.0,
      maximum: 14808.0,
      'gee:estimated_range': true,
    },
    velocity_v_50: {
      minimum: -17302.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_60: {
      minimum: -32768.0,
      maximum: 15986.0,
      'gee:estimated_range': true,
    },
    velocity_v_60: {
      minimum: -17070.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    velocity_u_70: {
      minimum: -32768.0,
      maximum: 14406.0,
      'gee:estimated_range': true,
    },
    velocity_v_70: {
      minimum: -16976.0,
      maximum: 22779.0,
      'gee:estimated_range': true,
    },
    velocity_u_80: {
      minimum: -32768.0,
      maximum: 27875.0,
      'gee:estimated_range': true,
    },
    velocity_v_80: {
      minimum: -16936.0,
      maximum: 23957.0,
      'gee:estimated_range': true,
    },
    velocity_u_90: {
      minimum: -32768.0,
      maximum: 27666.0,
      'gee:estimated_range': true,
    },
    velocity_v_90: {
      minimum: -16757.0,
      maximum: 23947.0,
      'gee:estimated_range': true,
    },
    velocity_u_100: {
      minimum: -32768.0,
      maximum: 24932.0,
      'gee:estimated_range': true,
    },
    velocity_v_100: {
      minimum: -16717.0,
      maximum: 23631.0,
      'gee:estimated_range': true,
    },
    velocity_u_125: {
      minimum: -32768.0,
      maximum: 24627.0,
      'gee:estimated_range': true,
    },
    velocity_v_125: {
      minimum: -14743.0,
      maximum: 23518.0,
      'gee:estimated_range': true,
    },
    velocity_u_150: {
      minimum: -32768.0,
      maximum: 24288.0,
      'gee:estimated_range': true,
    },
    velocity_v_150: {
      minimum: -14700.0,
      maximum: 23444.0,
      'gee:estimated_range': true,
    },
    velocity_u_200: {
      minimum: -32768.0,
      maximum: 21844.0,
      'gee:estimated_range': true,
    },
    velocity_v_200: {
      minimum: -13198.0,
      maximum: 23434.0,
      'gee:estimated_range': true,
    },
    velocity_u_250: {
      minimum: -32768.0,
      maximum: 21389.0,
      'gee:estimated_range': true,
    },
    velocity_v_250: {
      minimum: -13176.0,
      maximum: 23418.0,
      'gee:estimated_range': true,
    },
    velocity_u_300: {
      minimum: -32768.0,
      maximum: 14403.0,
      'gee:estimated_range': true,
    },
    velocity_v_300: {
      minimum: -3218.0,
      maximum: 21128.0,
      'gee:estimated_range': true,
    },
    velocity_u_350: {
      minimum: -32768.0,
      maximum: 11257.0,
      'gee:estimated_range': true,
    },
    velocity_v_350: {
      minimum: -3183.0,
      maximum: 20974.0,
      'gee:estimated_range': true,
    },
    velocity_u_400: {
      minimum: -32768.0,
      maximum: 14624.0,
      'gee:estimated_range': true,
    },
    velocity_v_400: {
      minimum: -3089.0,
      maximum: 21402.0,
      'gee:estimated_range': true,
    },
    velocity_u_500: {
      minimum: -32768.0,
      maximum: 11012.0,
      'gee:estimated_range': true,
    },
    velocity_v_500: {
      minimum: -2848.0,
      maximum: 20965.0,
      'gee:estimated_range': true,
    },
    velocity_u_600: {
      minimum: -32768.0,
      maximum: 10572.0,
      'gee:estimated_range': true,
    },
    velocity_v_600: {
      minimum: -2568.0,
      maximum: 20968.0,
      'gee:estimated_range': true,
    },
    velocity_u_700: {
      minimum: -32768.0,
      maximum: 10330.0,
      'gee:estimated_range': true,
    },
    velocity_v_700: {
      minimum: -2321.0,
      maximum: 21448.0,
      'gee:estimated_range': true,
    },
    velocity_u_800: {
      minimum: -32768.0,
      maximum: 8503.0,
      'gee:estimated_range': true,
    },
    velocity_v_800: {
      minimum: -2333.0,
      maximum: 20965.0,
      'gee:estimated_range': true,
    },
    velocity_u_900: {
      minimum: -32768.0,
      maximum: 6941.0,
      'gee:estimated_range': true,
    },
    velocity_v_900: {
      minimum: -2577.0,
      maximum: 20958.0,
      'gee:estimated_range': true,
    },
    velocity_u_1000: {
      minimum: -32768.0,
      maximum: 6951.0,
      'gee:estimated_range': true,
    },
    velocity_v_1000: {
      minimum: -2299.0,
      maximum: 20956.0,
      'gee:estimated_range': true,
    },
    velocity_u_1250: {
      minimum: -32768.0,
      maximum: 8351.0,
      'gee:estimated_range': true,
    },
    velocity_v_1250: {
      minimum: -2244.0,
      maximum: 20950.0,
      'gee:estimated_range': true,
    },
    velocity_u_1500: {
      minimum: -22775.0,
      maximum: 3659.0,
      'gee:estimated_range': true,
    },
    velocity_v_1500: {
      minimum: -2154.0,
      maximum: 20937.0,
      'gee:estimated_range': true,
    },
    velocity_u_2000: {
      minimum: -22448.0,
      maximum: 2811.0,
      'gee:estimated_range': true,
    },
    velocity_v_2000: {
      minimum: -2010.0,
      maximum: 20936.0,
      'gee:estimated_range': true,
    },
    velocity_u_2500: {
      minimum: -32768.0,
      maximum: 1865.0,
      'gee:estimated_range': true,
    },
    velocity_v_2500: {
      minimum: -1863.0,
      maximum: 18919.0,
      'gee:estimated_range': true,
    },
    velocity_u_3000: {
      minimum: -21841.0,
      maximum: 1677.0,
      'gee:estimated_range': true,
    },
    velocity_v_3000: {
      minimum: -1819.0,
      maximum: 18923.0,
      'gee:estimated_range': true,
    },
    velocity_u_4000: {
      minimum: -21345.0,
      maximum: 1980.0,
      'gee:estimated_range': true,
    },
    velocity_v_4000: {
      minimum: -1383.0,
      maximum: 18856.0,
      'gee:estimated_range': true,
    },
    velocity_u_5000: {
      minimum: -21469.0,
      maximum: 2013.0,
      'gee:estimated_range': true,
    },
    velocity_v_5000: {
      minimum: -971.0,
      maximum: 15383.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    J. A. Cummings and O. M. Smedstad. 2013: Variational Data Assimilation for
    the Global Ocean. Data Assimilation for Atmospheric, Oceanic and Hydrologic
    Applications vol II, chapter 13, 303-343.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': 'This dataset is freely available with no restrictions.',
}
