local id = 'NASA/GSFC/MERRA/lnd/2';
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
  title: 'MERRA-2 M2T1NXLND: Land Surface Diagnostics V5.12.4',
  version: '5.12.4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    M2T1NXLND (or tavg1_2d_lnd_Nx) is an hourly time-averaged data
    collection in Modern-Era Retrospective analysis for Research and
    Applications version 2 (MERRA-2). This collection consists of land
    surface diagnostics, such a baseflow flux, runoff, surface soil wetness,
    root zone soil wetness, water at surface layer, water at root zone
    layer, and soil temperature at six layers. The data field is
    time-stamped with the central time of an hour starting from 00:30 UTC,
    e.g.: 00:30, 01:30, ... , 23:30 UTC.

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
    // 'baresoil',
    // 'baseflow',
    'evaporation',
    // 'flux_energy',
    // 'greeness',
    'ice',
    // 'infiltration',
    // 'lnd',
    'merra',
    // 'snowcover',
    'temperature',
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
        name: 'BASEFLOW',
        description: 'Baseflow flux',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'ECHANGE',
        description: 'Rate of change of total land energy',
        'gee:units': 'W/m^2',
      },
      {
        name: 'EVLAND',
        description: 'Evaporation land',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'EVPINTR',
        description: 'Interception loss energy flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'EVPSBLN',
        description: 'Snow ice evaporation energy flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'EVPSOIL',
        description: 'Baresoil evaporation energy flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'EVPTRNS',
        description: 'Transpiration energy flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'FRSAT',
        description: 'Fractional area of saturated zone',
      },
      {
        name: 'FRSNO',
        description: 'Fractional area of land snowcover',
      },
      {
        name: 'FRUNST',
        description: 'Fractional area of unsaturated zone',
      },
      {
        name: 'FRWLT',
        description: 'Fractional area of wilting zone',
      },
      {
        name: 'GHLAND',
        description: 'Ground heating land',
        'gee:units': 'W/m^2',
      },
      {
        name: 'GRN',
        description: 'Greeness fraction',
      },
      {
        name: 'GWETPROF',
        description: 'Average prof soil moisture',
      },
      {
        name: 'GWETROOT',
        description: 'Root zone soil wetness',
      },
      {
        name: 'GWETTOP',
        description: 'Surface soil wetness',
      },
      {
        name: 'LAI',
        description: 'Leaf area index',
      },
      {
        name: 'LHLAND',
        description: 'Latent heat flux land',
        'gee:units': 'W/m^2',
      },
      {
        name: 'LWLAND',
        description: 'Net longwave land',
        'gee:units': 'W/m^2',
      },
      {
        name: 'PARDFLAND',
        description: |||
          Surface downwelling photosynthetic active radiation diffuse flux
        |||,
        'gee:units': 'W/m^2',
      },
      {
        name: 'PARDRLAND',
        description: 'Surface downwelling par beam flux',
        'gee:units': 'W/m^2',
      },
      {
        name: 'PRECSNOLAND',
        description: 'Snowfall land',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRECTOTLAND',
        description: 'Total precipitation land',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'PRMC',
        description: 'Water profile',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'QINFIL',
        description: 'Soil water infiltration rate',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'RUNOFF',
        description: 'Overland runoff including throughflow',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'RZMC',
        description: 'Water root zone',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SFMC',
        description: 'Water surface layer',
        'gee:units': units.volume_fraction,
      },
      {
        name: 'SHLAND',
        description: 'Sensible heat flux land',
        'gee:units': 'W/m^2',
      },
      {
        name: 'SMLAND',
        description: 'Snowmelt flux land',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'SNODP',
        description: 'Snow depth',
        'gee:units': units.meters,
      },
      {
        name: 'SNOMAS',
        description: 'Total snow storage land',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'SPLAND',
        description: 'Rate of spurious land energy source',
        'gee:units': 'W/m^2',
      },
      {
        name: 'SPSNOW',
        description: 'Rate of spurious snow energy',
        'gee:units': 'W/m^2',
      },
      {
        name: 'SPWATR',
        description: 'Rate of spurious land water source',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'SWLAND',
        description: 'Net shortwave land',
        'gee:units': 'W/m^2',
      },
      {
        name: 'TELAND',
        description: 'Total energy storage land',
        'gee:units': 'J/m^2',
      },
      {
        name: 'TPSNOW',
        description: 'Surface temperature of snow',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSAT',
        description: 'Surface temperature of saturated zone',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL1',
        description: 'Soil temperatures layer 1',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL2',
        description: 'Soil temperatures layer 2',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL3',
        description: 'Soil temperatures layer 3',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL4',
        description: 'Soil temperatures layer 4',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL5',
        description: 'Soil temperatures layer 5',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSOIL6',
        description: 'Soil temperatures layer 6',
        'gee:units': units.kelvin,
      },
      {
        name: 'TSURF',
        description: 'Surface temperature of land incl snow',
        'gee:units': units.kelvin,
      },
      {
        name: 'TUNST',
        description: 'Surface temperature of unsaturated zone',
        'gee:units': units.kelvin,
      },
      {
        name: 'TWLAND',
        description: 'Available water storage land',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'TWLT',
        description: 'Surface temperature of wilted zone',
        'gee:units': units.kelvin,
      },
      {
        name: 'WCHANGE',
        description: 'Rate of change of total land water',
        'gee:units': 'kg/m^2/s',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Baseflow flux',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.00000913,
            ],
            max: [
              0.00001076,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'BASEFLOW',
            ],
          },
        },
      },
    ],
    BASEFLOW: {
      minimum: 0.000000,
      maximum: 0.000129,
      'gee:estimated_range': true,
    },
    ECHANGE: {
      minimum: -2930.422119,
      maximum: 689.084106,
      'gee:estimated_range': true,
    },
    EVLAND: {
      minimum: -0.000110,
      maximum: 0.000682,
      'gee:estimated_range': true,
    },
    EVPINTR: {
      minimum: -55.257088,
      maximum: 582.820129,
      'gee:estimated_range': true,
    },
    EVPSBLN: {
      minimum: -310.133972,
      maximum: 729.170471,
      'gee:estimated_range': true,
    },
    EVPSOIL: {
      minimum: -0.588216,
      maximum: 1217.361816,
      'gee:estimated_range': true,
    },
    EVPTRNS: {
      minimum: -0.882528,
      maximum: 1635.844116,
      'gee:estimated_range': true,
    },
    FRSAT: {
      minimum: 0.000000,
      maximum: 0.983076,
      'gee:estimated_range': true,
    },
    FRSNO: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    FRUNST: {
      minimum: 0.000000,
      maximum: 0.999996,
      'gee:estimated_range': true,
    },
    FRWLT: {
      minimum: 0.000000,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    GHLAND: {
      minimum: -245.165024,
      maximum: 304.674652,
      'gee:estimated_range': true,
    },
    GRN: {
      minimum: 0.000000,
      maximum: 0.990087,
      'gee:estimated_range': true,
    },
    GWETPROF: {
      minimum: 0.086402,
      maximum: 0.999970,
      'gee:estimated_range': true,
    },
    GWETROOT: {
      minimum: 0.085486,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    GWETTOP: {
      minimum: 0.010069,
      maximum: 1.000000,
      'gee:estimated_range': true,
    },
    LAI: {
      minimum: 0.000000,
      maximum: 8.074079,
      'gee:estimated_range': true,
    },
    LHLAND: {
      minimum: -308.962158,
      maximum: 1682.572876,
      'gee:estimated_range': true,
    },
    LWLAND: {
      minimum: -318.505249,
      maximum: 47.539799,
      'gee:estimated_range': true,
    },
    PARDFLAND: {
      minimum: 0.000000,
      maximum: 277.006226,
      'gee:estimated_range': true,
    },
    PARDRLAND: {
      minimum: 0.000000,
      maximum: 441.662140,
      'gee:estimated_range': true,
    },
    PRECSNOLAND: {
      minimum: 0.000000,
      maximum: 0.008119,
      'gee:estimated_range': true,
    },
    PRECTOTLAND: {
      minimum: 0.000000,
      maximum: 0.110576,
      'gee:estimated_range': true,
    },
    PRMC: {
      minimum: 0.032228,
      maximum: 0.476084,
      'gee:estimated_range': true,
    },
    QINFIL: {
      minimum: 0.000000,
      maximum: 0.012518,
      'gee:estimated_range': true,
    },
    RUNOFF: {
      minimum: 0.000000,
      maximum: 0.104504,
      'gee:estimated_range': true,
    },
    RZMC: {
      minimum: 0.031886,
      maximum: 0.478268,
      'gee:estimated_range': true,
    },
    SFMC: {
      minimum: 0.003945,
      maximum: 0.478000,
      'gee:estimated_range': true,
    },
    SHLAND: {
      minimum: -1189.337036,
      maximum: 768.705994,
      'gee:estimated_range': true,
    },
    SMLAND: {
      minimum: 0.000000,
      maximum: 0.007922,
      'gee:estimated_range': true,
    },
    SNODP: {
      minimum: 0.000000,
      maximum: 9.300120,
      'gee:estimated_range': true,
    },
    SNOMAS: {
      minimum: 0.000000,
      maximum: 3964.600830,
      'gee:estimated_range': true,
    },
    SPLAND: {
      minimum: -71.821953,
      maximum: 754.466675,
      'gee:estimated_range': true,
    },
    SPSNOW: {
      minimum: -1287.324341,
      maximum: 127.014771,
      'gee:estimated_range': true,
    },
    SPWATR: {
      minimum: -0.000305,
      maximum: 0.000002,
      'gee:estimated_range': true,
    },
    SWLAND: {
      minimum: 0.000000,
      maximum: 1076.587158,
      'gee:estimated_range': true,
    },
    TELAND: {
      minimum: -2067449600.000000,
      maximum: 1094454400.000000,
      'gee:estimated_range': true,
    },
    TPSNOW: {
      minimum: 207.983902,
      maximum: 273.160065,
      'gee:estimated_range': true,
    },
    TSAT: {
      minimum: 231.970840,
      maximum: 319.159882,
      'gee:estimated_range': true,
    },
    TSOIL1: {
      minimum: 235.693649,
      maximum: 326.169342,
      'gee:estimated_range': true,
    },
    TSOIL2: {
      minimum: 236.820663,
      maximum: 317.313446,
      'gee:estimated_range': true,
    },
    TSOIL3: {
      minimum: 238.600372,
      maximum: 314.921021,
      'gee:estimated_range': true,
    },
    TSOIL4: {
      minimum: 241.158325,
      maximum: 313.186005,
      'gee:estimated_range': true,
    },
    TSOIL5: {
      minimum: 244.400024,
      maximum: 311.295197,
      'gee:estimated_range': true,
    },
    TSOIL6: {
      minimum: 249.435699,
      maximum: 309.734283,
      'gee:estimated_range': true,
    },
    TSURF: {
      minimum: 207.983902,
      maximum: 341.939148,
      'gee:estimated_range': true,
    },
    TUNST: {
      minimum: 231.302734,
      maximum: 341.938049,
      'gee:estimated_range': true,
    },
    TWLAND: {
      minimum: 42.965725,
      maximum: 4430.249023,
      'gee:estimated_range': true,
    },
    TWLT: {
      minimum: 231.302734,
      maximum: 341.939209,
      'gee:estimated_range': true,
    },
    WCHANGE: {
      minimum: -0.001769,
      maximum: 0.012293,
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
