local id = 'NOAA/GOES/16/MCMIPM';
local subdir = 'NOAA';

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
  ],
  id: id,
  title: 'GOES-16 MCMIPM Series ABI Level 2 Cloud and Moisture Imagery Mesoscale',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    [GOES](https://www.goes.noaa.gov) satellites are geostationary weather satellites run by NOAA.

    The Cloud and Moisture Imagery products are all at 2km
    resolution. Bands 1-6 are reflective. The dimensionless "reflectance factor" quantity is
    normalized by the solar zenith angle. These bands support the characterization of clouds,
    vegetation, snow/ice, and aerosols. Bands 7-16 are emissive. The brightness temperature at the
    Top-Of-Atmosphere (TOA) is measured in Kelvin. These bands support the characterization of the
    surface, clouds, water vapor, ozone, volcanic ash, and dust based on emissive properties.

    The locations of domains 1 and 2 change over time.

    [README](https://www.ncei.noaa.gov/products/satellite/goes-r-series)
  ||| + importstr 'general_satellite_messages_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/storage/browser/gcp-public-data-goes-16/ABI-L2-MCMIPM/',
    },
  ],
  keywords: [
    'abi',
    'climate',
    'goes',
    'goes_16',
    'goes_east',
    'goes_r',
    'mcmip',
    'nesdis',
    'noaa',
    'ospo',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://data.noaa.gov/onestop/collections/details/385d4d38-267e-40c1-859d-b5d8a079c5df'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2017-07-10T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'CMI_C01_offset',
        description: 'Offset to add to scaled CMI_C01 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C01_scale',
        description: 'Scale to multiply with raw CMI_C01 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C02_offset',
        description: 'Offset to add to scaled CMI_C02 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C02_scale',
        description: 'Scale to multiply with raw CMI_C02 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C03_offset',
        description: 'Offset to add to scaled CMI_C03 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C03_scale',
        description: 'Scale to multiply with raw CMI_C03 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C04_offset',
        description: 'Offset to add to scaled CMI_C04 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C04_scale',
        description: 'Scale to multiply with raw CMI_C04 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C05_offset',
        description: 'Offset to add to scaled CMI_C05 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C05_scale',
        description: 'Scale to multiply with raw CMI_C05 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C06_offset',
        description: 'Offset to add to scaled CMI_C06 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C06_scale',
        description: 'Scale to multiply with raw CMI_C06 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C07_offset',
        description: 'Offset to add to scaled CMI_C07 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C07_scale',
        description: 'Scale to multiply with raw CMI_C07 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C08_offset',
        description: 'Offset to add to scaled CMI_C08 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C08_scale',
        description: 'Scale to multiply with raw CMI_C08 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C09_offset',
        description: 'Offset to add to scaled CMI_C09 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C09_scale',
        description: 'Scale to multiply with raw CMI_C09 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C10_offset',
        description: 'Offset to add to scaled CMI_C10 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C10_scale',
        description: 'Scale to multiply with raw CMI_C10 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C11_offset',
        description: 'Offset to add to scaled CMI_C11 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C11_scale',
        description: 'Scale to multiply with raw CMI_C11 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C12_offset',
        description: 'Offset to add to scaled CMI_C12 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C12_scale',
        description: 'Scale to multiply with raw CMI_C12 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C13_offset',
        description: 'Offset to add to scaled CMI_C13 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C13_scale',
        description: 'Scale to multiply with raw CMI_C13 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C14_offset',
        description: 'Offset to add to scaled CMI_C14 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C14_scale',
        description: 'Scale to multiply with raw CMI_C14 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C15_offset',
        description: 'Offset to add to scaled CMI_C15 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C15_scale',
        description: 'Scale to multiply with raw CMI_C15 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C16_offset',
        description: 'Offset to add to scaled CMI_C16 values',
        type: ee_const.var_type.double,
      },
      {
        name: 'CMI_C16_scale',
        description: 'Scale to multiply with raw CMI_C16 values',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      2000.0,
    ],
    'eo:bands': [
      {
        name: 'CMI_C01',
        description: 'Visible - Blue\n\nDaytime aerosol over land, coastal water mapping.',
        'gee:units': 'Reflectance factor',
        center_wavelength: 0.47,
        'gee:wavelength': '0.45-0.49&micro;m',
      },
      {
        name: 'DQF_C01',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C02',
        description: 'Visible - Red\n\nDaytime clouds, fog, insolation, winds',
        'gee:units': 'Reflectance factor',
        center_wavelength: 0.64,
        'gee:wavelength': '0.59-0.69&micro;m',
      },
      {
        name: 'DQF_C02',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C03',
        description: 'Near-IR - Veggie\n\nDaytime vegetation, burn scar, aerosol over water, winds',
        'gee:units': 'Reflectance factor',
        center_wavelength: 0.865,
        'gee:wavelength': '0.846-0.885&micro;m',
      },
      {
        name: 'DQF_C03',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C04',
        description: 'Near-IR - Cirrus\n\nDaytime cirrus cloud',
        'gee:units': 'Reflectance factor',
        center_wavelength: 1.378,
        'gee:wavelength': '1.371-1.386&micro;m',
      },
      {
        name: 'DQF_C04',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C05',
        description: 'Near-IR - Snow/Ice\n\nDaytime cloud-top phase and particle size, snow',
        'gee:units': 'Reflectance factor',
        center_wavelength: 1.61,
        'gee:wavelength': '1.58-1.64&micro;m',
      },
      {
        name: 'DQF_C05',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C06',
        description: 'Near IR - Cloud Particle Size\n\nDaytime land, cloud properties, particle size, vegetation, snow',
        'gee:units': 'Reflectance factor',
        center_wavelength: 2.25,
        'gee:wavelength': '2.225-2.275&micro;m',
      },
      {
        name: 'DQF_C06',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C07',
        description: 'Infrared - Shortwave Window\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 3.89,
        'gee:wavelength': '3.80-4.00&micro;m',
      },
      {
        name: 'DQF_C07',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C08',
        description: 'Infrared - Upper-level water vapor\n\nHigh-level atmospheric water vapor, winds, rainfall\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 6.17,
        'gee:wavelength': '5.77-6.6&micro;m',
      },
      {
        name: 'DQF_C08',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C09',
        description: 'Infrared - Mid-level water vapor\n\nMid-level atmospheric water vapor, winds, rainfall\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 6.95,
        'gee:wavelength': '6.75-7.15&micro;m',
      },
      {
        name: 'DQF_C09',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C10',
        description: 'Infrared - Lower-level water vapor\n\nLower-level water vapor, winds, and sulfur dioxide\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 7.34,
        'gee:wavelength': '7.24-7.44&micro;m',
      },
      {
        name: 'DQF_C10',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C11',
        description: |||
          Infrared - Cloud-top phase

          Total water for stability, cloud phase, dust, sulfur dioxide, rainfall

          Brightness
        |||,
        'gee:units': units.kelvin,
        center_wavelength: 8.44,
        'gee:wavelength': '8.3-8.7&micro;m',
      },
      {
        name: 'DQF_C11',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C12',
        description: 'Infrared - Ozone\n\nTotal ozone, turbulence, winds',
        'gee:units': units.kelvin,
        center_wavelength: 9.61,
        'gee:wavelength': '9.42-9.8&micro;m',
      },
      {
        name: 'DQF_C12',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C13',
        description: 'Infrared - "Clean" longwave window\n\nSurface and clouds\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 10.35,
        'gee:wavelength': '10.1-10.6&micro;m',
      },
      {
        name: 'DQF_C13',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C14',
        description: 'Infrared - Longwave window\n\nImagery, sea surface temperature, clouds, rainfall\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 11.19,
        'gee:wavelength': '10.8-11.6&micro;m',
      },
      {
        name: 'DQF_C14',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C15',
        description: 'Infrared "Dirty" longwave\n\nTotal water, volcanic ash, sea surface temperature\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 12.3,
        'gee:wavelength': '11.8-12.8&micro;m',
      },
      {
        name: 'DQF_C15',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
      {
        name: 'CMI_C16',
        description: 'Infrared - CO_2 longwave\n\nAir temperature, cloud heights\n\nBrightness',
        'gee:units': units.kelvin,
        center_wavelength: 13.3,
        'gee:wavelength': '13.0-13.6&micro;m',
      },
      {
        name: 'DQF_C16',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good pixels',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Conditionally usable pixels',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Out of range pixels',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'No value pixels',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Focal plane temperature threshold exceeded',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Blue band',
        lookat: {
          lon: -75.0,
          lat: 39.76,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3000.0,
            ],
            bands: [
              'CMI_C01',
            ],
          },
        },
      },
    ],
    CMI_C01: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C01: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C02: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C02: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C03: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C03: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C04: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C04: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C05: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C05: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C06: {
      minimum: 0.0,
      maximum: 1.3,
      'gee:estimated_range': false,
    },
    DQF_C06: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C07: {
      minimum: 197.31,
      maximum: 411.86,
      'gee:estimated_range': false,
    },
    DQF_C07: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C08: {
      minimum: 138.05,
      maximum: 311.06,
      'gee:estimated_range': false,
    },
    DQF_C08: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C09: {
      minimum: 137.7,
      maximum: 311.08,
      'gee:estimated_range': false,
    },
    DQF_C09: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C10: {
      minimum: 126.91,
      maximum: 331.2,
      'gee:estimated_range': false,
    },
    DQF_C10: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C11: {
      minimum: 127.69,
      maximum: 341.3,
      'gee:estimated_range': false,
    },
    DQF_C11: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C12: {
      minimum: 117.49,
      maximum: 311.06,
      'gee:estimated_range': false,
    },
    DQF_C12: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C13: {
      minimum: 89.62,
      maximum: 341.27,
      'gee:estimated_range': false,
    },
    DQF_C13: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C14: {
      minimum: 96.19,
      maximum: 341.28,
      'gee:estimated_range': false,
    },
    DQF_C14: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C15: {
      minimum: 97.38,
      maximum: 341.28,
      'gee:estimated_range': false,
    },
    DQF_C15: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
    CMI_C16: {
      minimum: 92.7,
      maximum: 318.26,
      'gee:estimated_range': false,
    },
    DQF_C16: {
      minimum: 0.0,
      maximum: 4.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Bah, Gunshor, Schmit, Generation of GOES-16 True Color Imagery without a
    Green Band, 2018. [doi:10.1029/2018EA000379](https://doi.org/10.1029/2018EA000379)
  |||,
  'sci:publications': [
    {
      citation: |||
        Product User Guide (PUG) Volume 5, [L2+ Products](
        https://www.goes-r.gov/products/docs/PUG-L2+-vol5.pdf).
      |||,
    },
    {
      citation: |||
        Schmit, T., Griffith, P., et al, (2016), A closer look at the ABI on the GOES-R series, Bull.
        Amer. Meteor. Soc., 98(4), 681-698.
        [doi:10.1175/BAMS-D-15-00230.1](https://doi.org/10.1175/BAMS-D-15-00230.1)
      |||,
      doi: '10.1175/BAMS-D-15-00230.1',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'minute',
    interval: 10,
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use.
  |||,
}
