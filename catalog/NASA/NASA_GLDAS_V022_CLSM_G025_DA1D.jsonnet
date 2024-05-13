local id = 'NASA/GLDAS/V022/CLSM/G025/DA1D';
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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GLDAS-2.2: Global Land Data Assimilation System',
  version: 'V022',
  'gee:type': ee_const.gee_type.image_collection,
  description: (importstr 'NASA_GLDAS_V2_description.md') + |||
    GLDAS-2.2 is new to the GES DISC archive and currently includes a main
    product from CLSM-F2.5 with Data Assimilation for the Gravity Recovery and
    Climate Experiment (GRACE-DA) from February 2003 to present. The GLDAS-2.2
    data are available in two production streams: main and Early, only main one
    is ingested.

    The GLDAS-2.2 GRACE-DA product was simulated with Catchment-F2.5 in Land
    Information System (LIS) Version 7. The data product contains 24 land
    surface fields from February 1, 2003 to present.

    The simulation started on February 1, 2003 using the conditions from the
    GLDAS-2.0 Daily Catchment model simulation, forced with the meteorological
    analysis fields from the operational European Centre for Medium-Range
    Weather Forecasts (ECMWF) Integrated Forecasting System. The total
    terrestrial water anomaly observation from GRACE satellite was assimilated
    (Li et al, 2019). Due to the data agreement with ECMWF, this GLDAS-2.2 daily
    product does not include the meteorological forcing fields.

    Documentation:

    * [Readme](https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_CLSM025_DA1_D.2.2/doc/README_GLDAS2.pdf)

    * [How-to](https://disc.gsfc.nasa.gov/information/howto?tags=hydrology)

    * [GES DISC Hydrology Documentation](https://disc.gsfc.nasa.gov/information/documents?title=Hydrology%20Documentation)

    Provider's Note: the names with extension _tavg are variables
    averaged over the past 3-hours, the names with extension '_acc' are
    variables accumulated over the past 3-hours, the names with extension
    '_inst' are instantaneous variables, and the names with '_f' are
    forcing variables.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    '3_hourly',
    'climate',
    'evaporation',
    'forcing',
    'geophysical',
    'gldas',
    'humidity',
    'ldas',
    'nasa',
    'precipitation',
    'pressure',
    'radiation',
    'soil',
    'soil_moisture',
    'surface',
    'temperature',
    'wind',
  ],
  providers: [
    ee.producer_provider('NASA GES DISC at NASA Goddard Earth Sciences Data and Information Services Center', 'https://doi.org/10.5067/TXBMLX370XX8'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1700900796-GES_DISC',
  ],
  extent: ee.extent_global('2003-01-01T03:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'end_hour',
        description: 'End hour',
        type: ee_const.var_type.double,
      },
      {
        name: 'start_hour',
        description: 'Start hour',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'ACond_tavg',
        description: 'Aerodynamic conductance',
        'gee:units': units.velocity_si,
      },
      {
        name: 'AvgSurfT_tavg',
        description: 'Average surface skin temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'CanopInt_tavg',
        description: 'Plant canopy surface water',
        'gee:units': units.area_density,
      },
      {
        name: 'ECanop_tavg',
        description: 'Canopy water evaporation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'ESoil_tavg',
        description: 'Direct evaporation from bare soil',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'EvapSnow_tavg',
        description: 'Snow Evaporation',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'Evap_tavg',
        description: 'Evapotranspiration',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'GWS_tavg',
        description: 'Ground water storage',
        'gee:units': units.millimeter,
      },
      {
        name: 'Lwnet_tavg',
        description: 'Net long-wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qg_tavg',
        description: 'Heat flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qh_tavg',
        description: 'Sensible heat net flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qle_tavg',
        description: 'Latent heat net flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Qsb_tavg',
        description: 'Baseflow-groundwater runoff',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'Qsm_tavg',
        description: 'Snow melt',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'Qs_tavg',
        description: 'Storm surface runoff',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'SnowDepth_tavg',
        description: 'Snow depth',
        'gee:units': units.meter,
      },
      {
        name: 'SnowT_tavg',
        description: 'Snow Surface temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilMoist_P_tavg',
        description: 'Profile Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilMoist_RZ_tavg',
        description: 'Root Zone Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilMoist_S_tavg',
        description: 'Surface Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SWE_tavg',
        description: 'Snow depth water equivalent',
        'gee:units': units.area_density,
      },
      {
        name: 'Swnet_tavg',
        description: 'Net short wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'TVeg_tavg',
        description: 'Transpiration',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'TWS_tavg',
        description: 'Terrestrial water storage',
        'gee:units': units.millimeter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Average Surface Skin Temperature [K]',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              258.0,
            ],
            max: [
              316.0,
            ],
            palette: [
              '1303ff',
              '42fff6',
              'f3ff40',
              'ff5d0f',
            ],
            bands: [
              'AvgSurfT_tavg',
            ],
          },
        },
      },
    ],
    ACond_tavg: {
      minimum: 0.000379,
      maximum: 5.992911,
      'gee:estimated_range': true,
    },
    AvgSurfT_tavg: {
      minimum: 179.817886,
      maximum: 324.264923,
      'gee:estimated_range': true,
    },
    CanopInt_tavg: {
      minimum: 0.000000,
      maximum: 1.572948,
      'gee:estimated_range': true,
    },
    ECanop_tavg: {
      minimum: -0.021881,
      maximum: 0.000053,
      'gee:estimated_range': true,
    },
    ESoil_tavg: {
      minimum: -0.003637,
      maximum: 0.001172,
      'gee:estimated_range': true,
    },
    EvapSnow_tavg: {
      minimum: -0.021057,
      maximum: 0.000728,
      'gee:estimated_range': true,
    },
    Evap_tavg: {
      minimum: -0.027370,
      maximum: 0.001210,
      'gee:estimated_range': true,
    },
    GWS_tavg: {
      minimum: 77.015259,
      maximum: 3599.007812,
      'gee:estimated_range': true,
    },
    Lwnet_tavg: {
      minimum: -221.308334,
      maximum: 490.842438,
      'gee:estimated_range': true,
    },
    Qg_tavg: {
      minimum: -344.072418,
      maximum: 174.035950,
      'gee:estimated_range': true,
    },
    Qh_tavg: {
      minimum: -2851.748779,
      maximum: 54076.722656,
      'gee:estimated_range': true,
    },
    Qle_tavg: {
      minimum: -53856.621094,
      maximum: 2983.651367,
      'gee:estimated_range': true,
    },
    Qs_tavg: {
      minimum: 0.000000,
      maximum: 0.020244,
      'gee:estimated_range': true,
    },
    Qsb_tavg: {
      minimum: 0.000000,
      maximum: 0.000416,
      'gee:estimated_range': true,
    },
    Qsm_tavg: {
      minimum: 0.000000,
      maximum: 0.018311,
      'gee:estimated_range': true,
    },
    SWE_tavg: {
      minimum: 0.000000,
      maximum: 3688.072998,
      'gee:estimated_range': true,
    },
    SnowDepth_tavg: {
      minimum: 0.000000,
      maximum: 8.579514,
      'gee:estimated_range': true,
    },
    SnowT_tavg: {
      minimum: 179.817886,
      maximum: 324.264923,
      'gee:estimated_range': true,
    },
    SoilMoist_P_tavg: {
      minimum: 109.394073,
      maximum: 4049.024170,
      'gee:estimated_range': true,
    },
    SoilMoist_RZ_tavg: {
      minimum: 32.366474,
      maximum: 478.396606,
      'gee:estimated_range': true,
    },
    SoilMoist_S_tavg: {
      minimum: 0.001389,
      maximum: 9.559996,
      'gee:estimated_range': true,
    },
    Swnet_tavg: {
      minimum: 0.000000,
      maximum: 421.784241,
      'gee:estimated_range': true,
    },
    TVeg_tavg: {
      minimum: -0.000371,
      maximum: 0.001654,
      'gee:estimated_range': true,
    },
    TWS_tavg: {
      minimum: 109.394104,
      maximum: 5084.162598,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Li, B., M. Rodell, S. Kumar, H. Beaudoing, A. Getirana, B. F. Zaitchik, et
    al. (2019) Global GRACE data assimilation for groundwater and drought
    monitoring: Advances and challenges. Water Resources Research, 55,
    7564-7586.
  |||,
  'sci:publications': [
    {
      citation: '[Additional references](https://ldas.gsfc.nasa.gov/gldas/GLDASpublications.php)',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Distribution of data from the Goddard Earth Sciences
    Data and Information Services Center (GES DISC) is funded by NASA's
    Science Mission Directorate (SMD). Consistent with NASA [Earth
    Science Data and Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy/),
    data from the GES DISC archive are available free to the user community.
    For more information visit the GES DISC [Data Policy](https://disc.sci.gsfc.nasa.gov/citing)
    page.
  |||,
}
