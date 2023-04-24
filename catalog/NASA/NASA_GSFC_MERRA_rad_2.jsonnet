local id = 'NASA/GSFC/MERRA/rad/2';
local subdir = 'NASA';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MERRA-2 M2T1NXRAD: Radiation Diagnostics V5.12.4',
  version: '5.12.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    M2T1NXRAD (or tavg1_2d_rad_Nx) is an hourly time-averaged data
    collection in Modern-Era Retrospective analysis for Research and
    Applications version 2 (MERRA-2). This collection consists of radiation
    diagnostics, such as surface albedo, cloud area fraction, in cloud
    optical thickness, surface incoming shortwave flux (i.e. solar
    radiation), surface net downward shortwave flux, and upwelling longwave
    flux at TOA (top of atmosphere) (i.e. outgoing longwave radiation (OLR)
    at TOA). The data field is time-stamped with the central time of an hour
    starting from 00:30 UTC, e.g.: 00:30, 01:30, ... , 23:30 UTC.

    MERRA-2 is the latest version of global atmospheric reanalysis for the
    satellite era produced by NASA Global Modeling and Assimilation Office
    (GMAO) using the Goddard Earth Observing System Model (GEOS) version
    5.12.4. The dataset covers the period of 1980-present with the latency
    of ~3 weeks after the end of a month.
  |||,
  license: license.id,
  links:  ee.standardLinks(subdir, id) + [
    ee.link.license(
    'https://earthdata.nasa.gov/collaborate/open-data-services-and-software/data-information-policy'
    ),
  ],
  keywords: [
    'albedo',
    // 'clouds',
    'emissivity',
    // 'longwave_radiation',
    'merra',
    // 'rad',
    'shortwave',
    'temperature',
    // 'upwelling',
  ],
  providers: [
    ee.producer_provider(
      'NASA/MERRA',
      'https://gmao.gsfc.nasa.gov/reanalysis/MERRA-2/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1980-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      69375,
      55000
    ],
    'eo:bands': [
      {
        name: 'ALBEDO',
        description: 'Surface albedo',
      },
      {
        name: 'ALBNIRDF',
        description: 'Surface albedo for near infrared diffuse',
      },
      {
        name: 'ALBNIRDR',
        description: 'Surface albedo for near infrared beam',
      },
      {
        name: 'ALBVISDF',
        description: 'Surface albedo for visible diffuse',
      },
      {
        name: 'ALBVISDR',
        description: 'Surface albedo for visible beam',
      },
      {
        name: 'CLDHGH',
        description: 'Cloud area fraction for high clouds',
      },
      {
        name: 'CLDLOW',
        description: 'Cloud area fraction for low clouds',
      },
      {
        name: 'CLDMID',
        description: 'Cloud area fraction for middle clouds',
      },
      {
        name: 'CLDTOT',
        description: 'Total cloud area fraction',
      },
      {
        name: 'EMIS',
        description: 'Surface emissivity',
      },
      {
        name: 'LWGABCLRCLN',
        description: 'Surface absorbed longwave radiation assuming clear sky and no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGABCLR',
        description: 'Surface absorbed longwave radiation assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGAB',
        description: 'Surface absorbed longwave radiation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGEM',
        description: 'Longwave flux emitted from surface',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGNTCLRCLN',
        description: 'Surface net downward longwave flux assuming clear sky and no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGNTCLR',
        description: 'Surface net downward longwave flux assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWGNT',
        description: 'Surface net downward longwave flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWTUPCLRCLN',
        description: 'Upwelling longwave flux at TOA assuming clear sky and no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWTUPCLR',
        description: 'Upwelling longwave flux at TOA assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'LWTUP',
        description: 'Upwelling longwave flux at TOA',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGDNCLR',
        description: 'Surface incoming shortwave flux assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGDN',
        description: 'Surface incoming shortwave flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGNTCLN',
        description: 'Surface net downward shortwave flux assuming no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGNTCLRCLN',
        description: 'Surface net downward shortwave flux assuming clear sky and no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGNTCLR',
        description: 'Surface net downward shortwave flux assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWGNT',
        description: 'Surface net downward shortwave flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWTDN',
        description: 'TOA incoming shortwave flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWTNTCLN',
        description: 'TOA net downward shortwave flux assuming no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWTNTCLRCLN',
        description: 'TOA net downward shortwave flux assuming clear sky and no aerosol',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWTNTCLR',
        description: 'TOA net downward shortwave flux assuming clear sky',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SWTNT',
        description: 'TOA net downward shortwave flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'TAUHGH',
        description: 'In cloud optical thickness of high clouds(export)',
      },
      {
        name: 'TAULOW',
        description: 'In cloud optical thickness of low clouds',
      },
      {
        name: 'TAUMID',
        description: 'In cloud optical thickness of middle clouds',
      },
      {
        name: 'TAUTOT',
        description: 'In cloud optical thickness of all clouds',
      },
      {
        name: 'TS',
        description: 'Surface skin temperature',
        'gee:units': units.kelvin,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface albedo',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.428147,
            ],
            max: [
              0.833350,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'ALBEDO',
            ],
          },
        },
      },
    ],
    ALBEDO: {
      minimum: 0.010000,
      maximum: 0.898471,
      'gee:estimated_range': true,
    },
    ALBNIRDF: {
      minimum: 0.017455,
      maximum: 0.820016,
      'gee:estimated_range': true,
    },
    ALBNIRDR: {
      minimum: 0.018709,
      maximum: 0.820010,
      'gee:estimated_range': true,
    },
    ALBVISDF: {
      minimum: 0.016788,
      maximum: 0.959771,
      'gee:estimated_range': true,
    },
    ALBVISDR: {
      minimum: 0.018530,
      maximum: 0.959762,
      'gee:estimated_range': true,
    },
    CLDHGH: {
      minimum: 0.000000,
      maximum: 0.999236,
      'gee:estimated_range': true,
    },
    CLDLOW: {
      minimum: 0.000000,
      maximum: 0.999997,
      'gee:estimated_range': true,
    },
    CLDMID: {
      minimum: 0.000000,
      maximum: 0.998779,
      'gee:estimated_range': true,
    },
    CLDTOT: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    EMIS: {
      minimum: 0.943074,
      maximum: 0.999993,
      'gee:estimated_range': true,
    },
    LWGABCLRCLN: {
      minimum: 41.140797,
      maximum: 458.522949,
      'gee:estimated_range': true,
    },
    LWGABCLR: {
      minimum: 41.141357,
      maximum: 465.928528,
      'gee:estimated_range': true,
    },
    LWGAB: {
      minimum: 41.144592,
      maximum: 482.397766,
      'gee:estimated_range': true,
    },
    LWGEM: {
      minimum: 67.529724,
      maximum: 630.289917,
      'gee:estimated_range': true,
    },
    LWGNTCLRCLN: {
      minimum: -248.747910,
      maximum: 61.073635,
      'gee:estimated_range': true,
    },
    LWGNTCLR: {
      minimum: -248.652710,
      maximum: 62.279442,
      'gee:estimated_range': true,
    },
    LWGNT: {
      minimum: -268.861694,
      maximum: 77.254967,
      'gee:estimated_range': true,
    },
    LWTUPCLRCLN: {
      minimum: 80.676796,
      maximum: 372.229187,
      'gee:estimated_range': true,
    },
    LWTUPCLR: {
      minimum: 80.676796,
      maximum: 372.229187,
      'gee:estimated_range': true,
    },
    LWTUP: {
      minimum: 80.650604,
      maximum: 370.868256,
      'gee:estimated_range': true,
    },
    SWGDNCLR: {
      minimum: -0.008217,
      maximum: 1155.500000,
      'gee:estimated_range': true,
    },
    SWGDN: {
      minimum: 0.000000,
      maximum: 1127.491943,
      'gee:estimated_range': true,
    },
    SWGNTCLN: {
      minimum: 0.000000,
      maximum: 1088.418091,
      'gee:estimated_range': true,
    },
    SWGNTCLRCLN: {
      minimum: -0.000032,
      maximum: 1088.418091,
      'gee:estimated_range': true,
    },
    SWGNTCLR: {
      minimum: -0.001333,
      maximum: 1083.949097,
      'gee:estimated_range': true,
    },
    SWGNT: {
      minimum: 0.000000,
      maximum: 1083.949097,
      'gee:estimated_range': true,
    },
    SWTDN: {
      minimum: 0.000000,
      maximum: 1404.283936,
      'gee:estimated_range': true,
    },
    SWTNTCLN: {
      minimum: 0.000000,
      maximum: 1315.887085,
      'gee:estimated_range': true,
    },
    SWTNTCLRCLN: {
      minimum: 0.000000,
      maximum: 1317.500000,
      'gee:estimated_range': true,
    },
    SWTNTCLR: {
      minimum: 0.000000,
      maximum: 1316.500000,
      'gee:estimated_range': true,
    },
    SWTNT: {
      minimum: 0.000000,
      maximum: 1313.333008,
      'gee:estimated_range': true,
    },
    TAUHGH: {
      minimum: 0.000000,
      maximum: 142.187500,
      'gee:estimated_range': true,
    },
    TAULOW: {
      minimum: 0.000000,
      maximum: 318.217560,
      'gee:estimated_range': true,
    },
    TAUMID: {
      minimum: 0.000000,
      maximum: 252.995132,
      'gee:estimated_range': true,
    },
    TAUTOT: {
      minimum: 0.000000,
      maximum: 348.125000,
      'gee:estimated_range': true,
    },
    TS: {
      minimum: 185.729706,
      maximum: 328.863831,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': |||
    NASA promotes the full and open sharing of all data with research and
    applications communities, private industry, academia, and the general
    public.
  |||
}
