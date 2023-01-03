local id = 'NASA/GSFC/MERRA/flx/2';
local subdir = 'NASA/GSFC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MERRA-2 M2T1NXFLX: Surface Flux Diagnostics V5.12.4',
  version: '5.12.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    M2T1NXFLX (or tavg1_2d_flx_Nx) is an hourly time-averaged data
    collection in Modern-Era Retrospective analysis for Research and
    Applications version 2 (MERRA-2). This collection consists of
    assimilated surface flux diagnostics, such as total precipitation, bias
    corrected total precipitation, surface air temperature, surface specific
    humidity, surface wind speed, and evaporation from turbulence. The
    "surface" in this data collection is the model surface layer. The
    heights of the model surface layer (HLML) vary with time and location,
    with the value of ~60 meters above ground. The data field is time-stamped
    with the central time of an hour starting from 00:30 UTC, e.g.: 00:30,
    01:30, ... , 23:30 UTC.

    MERRA-2 is the latest version of global atmospheric reanalysis for the
    satellite era produced by [NASA Global Modeling and Assimilation Office
    (GMAO)](https://gmao.gsfc.nasa.gov/) using the [Goddard Earth Observing
    System Model (GEOS)](https://gmao.gsfc.nasa.gov/GEOS_systems/) version
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
    // 'buoyancy',
    // 'drag',
    // 'heat_flux',
    'merra',
    // 'momentum',
    'sea_salt',
    'so2',
    'so4',
    'soil_moisture',
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
        name: 'BSTAR',
        description: 'Surface buoyancy scale',
        'gee:units': 'm/s^2',
      },
      {
        name: 'CDH',
        description: 'Surface exchange coefficient for heat',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'CDM',
        description: 'Surface exchange coefficient for momentum',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'CDQ',
        description: 'Surface exchange coefficient for moisture',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'CN',
        description: 'Surface neutral drag coefficient',
      },
      {
        name: 'DISPH',
        description: 'Zero plane displacement height',
        'gee:units': 'm',
      },
      {
        name: 'EFLUX',
        description: 'Total latent energy flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'EVAP',
        description: 'Evaporation from turbulence',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'FRCAN',
        description: 'Areal fraction of anvil showers',
      },
      {
        name: 'FRCCN',
        description: 'Areal fraction of convective showers',
      },
      {
        name: 'FRCLS',
        description: 'Areal fraction of nonanvil large scale showers',
      },
      {
        name: 'FRSEAICE',
        description: 'Ice covered fraction of tile',
      },
      {
        name: 'GHTSKIN',
        description: 'Ground heating for skin temperature',
        'gee:units': 'W/m^2',
      },
      {
        name: 'HFLUX',
        description: 'Sensible heat flux from turbulence',
        'gee:units': 'W/m^2',
      },
      {
        name: 'HLML',
        description: 'Surface layer height',
        'gee:units': 'm',
      },
      {
        name: 'NIRDF',
        description: 'Surface downwelling nearinfrared diffuse flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'NIRDR',
        description: 'Surface downwelling nearinfrared beam flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'PBLH',
        description: 'Planetary boundary layer height',
        'gee:units': 'm',
      },
      {
        name: 'PGENTOT',
        description: 'Total column production of precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECANV',
        description: 'Anvil precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECCON',
        description: 'Convective precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECLSC',
        description: 'Nonanvil large scale precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECSNO',
        description: 'Snowfall',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECTOTCORR',
        description: 'Total precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECTOT',
        description: 'Total precipitation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PREVTOT',
        description: |||
          Total column re-evaporation/sublimation of precipitation
        |||,
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'QLML',
        description: 'Surface specific humidity',

      },
      {
        name: 'QSH',
        description: 'Effective surface specific humidity',
        'gee:units': 'kg/kg',
      },
      {
        name: 'QSTAR',
        description: 'Surface moisture scale',
        'gee:units': 'kg/kg',
      },
      {
        name: 'RHOA',
        description: 'Air density at surface',
        'gee:units': 'kg/m^3',
      },
      {
        name: 'RISFC',
        description: 'Surface bulk Richardson number',

      },
      {
        name: 'SPEEDMAX',
        description: 'Surface wind speed',
        'gee:units': 'm/s',
      },
      {
        name: 'SPEED',
        description: 'Surface wind speed',
        'gee:units': 'm/s',
      },
      {
        name: 'TAUGWX',
        description: 'Surface eastward gravity wave stress',
        'gee:units': 'N/m^2',
      },
      {
        name: 'TAUGWY',
        description: 'Surface northward gravity wave stress',
        'gee:units': 'N/m^2',
      },
      {
        name: 'TAUX',
        description: 'Eastward surface stress',
        'gee:units': 'N/m^2',
      },
      {
        name: 'TAUY',
        description: 'Northward surface stress',
        'gee:units': 'N/m^2',
      },
      {
        name: 'TCZPBL',
        description: 'Transcom planetary boundary layer height',
        'gee:units': 'm',
      },
      {
        name: 'TLML',
        description: 'Surface air temperature',
        'gee:units': 'K',
      },
      {
        name: 'TSH',
        description: 'Effective surface skin temperature',
        'gee:units': 'K',
      },
      {
        name: 'TSTAR',
        description: 'Surface temperature scale',
        'gee:units': 'K',
      },
      {
        name: 'ULML',
        description: 'Surface eastward wind',
        'gee:units': 'm/s',
      },
      {
        name: 'USTAR',
        description: 'Surface velocity scale',
        'gee:units': 'm/s',
      },
      {
        name: 'VLML',
        description: 'Surface northward wind',
        'gee:units': 'm/s',
      },
      {
        name: 'Z0H',
        description: 'Surface roughness for heat',
        'gee:units': 'm',
      },
      {
        name: 'Z0M',
        description: 'Surface roughness',
        'gee:units': 'm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface buoyancy scale',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.00998,
            ],
            max: [
              0.01174,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'BSTAR',
            ],
          },
        },
      },
    ],
    BSTAR: {
      minimum: -0.021035,
      maximum: 0.791739,
      'gee:estimated_range': true,
    },
    CDH: {
      minimum: 0.000008,
      maximum: 0.522482,
      'gee:estimated_range': true,
    },
    CDM: {
      minimum: 0.000005,
      maximum: 0.518079,
      'gee:estimated_range': true,
    },
    CDQ: {
      minimum: 0.000008,
      maximum: 0.522482,
      'gee:estimated_range': true,
    },
    CN: {
      minimum: 0.000646,
      maximum: 0.032227,
      'gee:estimated_range': true,
    },
    DISPH: {
      minimum: 0.000000,
      maximum: 23.078125,
      'gee:estimated_range': true,
    },
    EFLUX: {
      minimum: -308.948822,
      maximum: 1655.850464,
      'gee:estimated_range': true,
    },
    EVAP: {
      minimum: -0.000110,
      maximum: 0.000673,
      'gee:estimated_range': true,
    },
    FRCAN: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    FRCCN: {
      minimum: 0.000000,
      maximum: 0.423096,
      'gee:estimated_range': true,
    },
    FRCLS: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    FRSEAICE: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    GHTSKIN: {
      minimum: -245.078445,
      maximum: 999999986991104.000000,
      'gee:estimated_range': true,
    },
    HFLUX: {
      minimum: -1181.242188,
      maximum: 686.742310,
      'gee:estimated_range': true,
    },
    HLML: {
      minimum: 42.364204,
      maximum: 71.059944,
      'gee:estimated_range': true,
    },
    NIRDF: {
      minimum: 0.000000,
      maximum: 282.495270,
      'gee:estimated_range': true,
    },
    NIRDR: {
      minimum: 0.000000,
      maximum: 592.216736,
      'gee:estimated_range': true,
    },
    PBLH: {
      minimum: 42.362129,
      maximum: 5780.884766,
      'gee:estimated_range': true,
    },
    PGENTOT: {
      minimum: 0.000000,
      maximum: 0.017593,
      'gee:estimated_range': true,
    },
    PRECANV: {
      minimum: 0.000000,
      maximum: 0.000968,
      'gee:estimated_range': true,
    },
    PRECCON: {
      minimum: 0.000000,
      maximum: 0.002629,
      'gee:estimated_range': true,
    },
    PRECLSC: {
      minimum: 0.000000,
      maximum: 0.014614,
      'gee:estimated_range': true,
    },
    PRECSNO: {
      minimum: 0.000000,
      maximum: 0.006308,
      'gee:estimated_range': true,
    },
    PRECTOTCORR: {
      minimum: 0.000000,
      maximum: 0.110565,
      'gee:estimated_range': true,
    },
    PRECTOT: {
      minimum: 0.000000,
      maximum: 0.017509,
      'gee:estimated_range': true,
    },
    PREVTOT: {
      minimum: 0.000000,
      maximum: 0.001474,
      'gee:estimated_range': true,
    },
    QLML: {
      minimum: 0.000000,
      maximum: 0.034333,
      'gee:estimated_range': true,
    },
    QSH: {
      minimum: 0.000000,
      maximum: 0.044069,
      'gee:estimated_range': true,
    },
    QSTAR: {
      minimum: -0.000139,
      maximum: 0.005463,
      'gee:estimated_range': true,
    },
    RHOA: {
      minimum: 0.658498,
      maximum: 1.682832,
      'gee:estimated_range': true,
    },
    RISFC: {
      minimum: -318.273376,
      maximum: 578.049988,
      'gee:estimated_range': true,
    },
    SPEEDMAX: {
      minimum: 0.074227,
      maximum: 49.476730,
      'gee:estimated_range': true,
    },
    SPEED: {
      minimum: 0.061141,
      maximum: 49.354137,
      'gee:estimated_range': true,
    },
    TAUGWX: {
      minimum: -3.062940,
      maximum: 5.871597,
      'gee:estimated_range': true,
    },
    TAUGWY: {
      minimum: -5.106486,
      maximum: 4.995545,
      'gee:estimated_range': true,
    },
    TAUX: {
      minimum: -5.488647,
      maximum: 5.093781,
      'gee:estimated_range': true,
    },
    TAUY: {
      minimum: -6.190365,
      maximum: 4.191915,
      'gee:estimated_range': true,
    },
    TCZPBL: {
      minimum: 6.558640,
      maximum: 2837115.250000,
      'gee:estimated_range': true,
    },
    TLML: {
      minimum: 191.832565,
      maximum: 320.173889,
      'gee:estimated_range': true,
    },
    TSH: {
      minimum: 185.729675,
      maximum: 328.859314,
      'gee:estimated_range': true,
    },
    TSTAR: {
      minimum: -11.076050,
      maximum: 5.744015,
      'gee:estimated_range': true,
    },
    ULML: {
      minimum: -48.808193,
      maximum: 42.823917,
      'gee:estimated_range': true,
    },
    USTAR: {
      minimum: 0.000667,
      maximum: 2.318440,
      'gee:estimated_range': true,
    },
    VLML: {
      minimum: -41.940773,
      maximum: 44.377689,
      'gee:estimated_range': true,
    },
    Z0H: {
      minimum: 0.000010,
      maximum: 4.546224,
      'gee:estimated_range': true,
    },
    Z0M: {
      minimum: 0.000010,
      maximum: 4.546224,
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
