local id = 'NASA/GLDAS/V20/NOAH/G025/T3H';
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
  title: 'Reprocessed GLDAS-2.0: Global Land Data Assimilation System',
  version: 'V20',
  'gee:type': ee_const.gee_type.image_collection,
  description: (importstr 'NASA_GLDAS_V2_description.md') + |||
    GLDAS-2.0 is one of two components of the GLDAS Version 2 (GLDAS-2)
    dataset, the second being GLDAS-2.1. GLDAS-2.0 is reprocessed with
    the updated Princeton Global Meteorological Forcing Dataset
    (Sheffield et al., 2006) and upgraded Land Information System
    Version 7 (LIS-7). It covers the period 1948-2010, and will be extended
    to more recent years as corresponding forcing data become available.

    The model simulation was initialized on January 1, 1948, using soil
    moisture and other state fields from the LSM climatology for
    that day of the year. The simulation used the common GLDAS datasets
    for land cover (MCD12Q1: Friedl et al., 2010), land water mask
    (MOD44W: Carroll et al., 2009), soil texture (Reynolds, 1999), and
    elevation (GTOPO30). The MODIS based land surface parameters are used in
    the current GLDAS-2.x products while the AVHRR base parameters were used
    in GLDAS-1 and previous GLDAS-2 products (prior to October 2012).

    Documentation:

    * [Readme](https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_NOAH025_3H.2.0/doc/README_GLDAS2.pdf)

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
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/342OHQM9AK6Q'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1233767545-GES_DISC',
  ],
  extent: ee.extent_global('1948-01-01T03:00:00Z', '2014-12-31T21:00:00Z'),
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
        name: 'Albedo_inst',
        description: 'Albedo',
        'gee:units': units.percent,
      },
      {
        name: 'AvgSurfT_inst',
        description: 'Average surface skin temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'CanopInt_inst',
        description: 'Plant canopy surface water',
        'gee:units': units.area_density,
      },
      {
        name: 'ECanop_tavg',
        description: 'Canopy water evaporation',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'ESoil_tavg',
        description: 'Direct evaporation from bare soil',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Evap_tavg',
        description: 'Evapotranspiration',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'LWdown_f_tavg',
        description: 'Downward long-wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Lwnet_tavg',
        description: 'Net long-wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'PotEvap_tavg',
        description: 'Potential evaporation rate',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Psurf_f_inst',
        description: 'Pressure',
        'gee:units': units.pascal,
      },
      {
        name: 'Qair_f_inst',
        description: 'Specific humidity',
        'gee:units': units.mass_fraction,
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
        name: 'Qs_acc',
        description: 'Storm surface runoff',
        'gee:units': units.area_density,
      },
      {
        name: 'Qsb_acc',
        description: 'Baseflow-groundwater runoff',
        'gee:units': units.area_density,
      },
      {
        name: 'Qsm_acc',
        description: 'Snow melt',
        'gee:units': units.area_density,
      },
      {
        name: 'Rainf_f_tavg',
        description: 'Total precipitation rate',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'Rainf_tavg',
        description: 'Rain precipitation rate',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'RootMoist_inst',
        description: 'Root zone soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SWE_inst',
        description: 'Snow depth water equivalent',
        'gee:units': units.area_density,
      },
      {
        name: 'SWdown_f_tavg',
        description: 'Downward short-wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'SnowDepth_inst',
        description: 'Snow depth',
        'gee:units': units.meter,
      },
      {
        name: 'Snowf_tavg',
        description: 'Snow precipitation rate',
        'gee:units': 'kg/m^2/s',
      },
      {
        name: 'SoilMoi0_10cm_inst',
        description: 'Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilMoi10_40cm_inst',
        description: 'Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilMoi40_100cm_inst',
        description: 'Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilMoi100_200cm_inst',
        description: 'Soil moisture',
        'gee:units': units.area_density,
      },
      {
        name: 'SoilTMP0_10cm_inst',
        description: 'Soil temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTMP10_40cm_inst',
        description: 'Soil temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTMP40_100cm_inst',
        description: 'Soil temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'SoilTMP100_200cm_inst',
        description: 'Soil temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'Swnet_tavg',
        description: 'Net short wave radiation flux',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Tair_f_inst',
        description: 'Air temperature',
        'gee:units': units.kelvin,
      },
      {
        name: 'Tveg_tavg',
        description: 'Transpiration',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Wind_f_inst',
        description: 'Wind speed',
        'gee:units': units.velocity_si,
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
              250.0,
            ],
            max: [
              300.0,
            ],
            palette: [
              '1303ff',
              '42fff6',
              'f3ff40',
              'ff5d0f',
            ],
            bands: [
              'AvgSurfT_inst',
            ],
          },
        },
      },
    ],
    Albedo_inst: {
      minimum: 4.99,
      maximum: 82.25,
      'gee:estimated_range': true,
    },
    AvgSurfT_inst: {
      minimum: 194.55,
      maximum: 351.63,
      'gee:estimated_range': true,
    },
    CanopInt_inst: {
      minimum: 0.0,
      maximum: 0.5,
      'gee:estimated_range': true,
    },
    ECanop_tavg: {
      minimum: 0.0,
      maximum: 671.88,
      'gee:estimated_range': true,
    },
    ESoil_tavg: {
      minimum: 0.0,
      maximum: 592.64,
      'gee:estimated_range': true,
    },
    Evap_tavg: {
      minimum: 0.0,
      maximum: 0.0002,
      'gee:estimated_range': true,
    },
    LWdown_f_tavg: {
      minimum: 44.62,
      maximum: 561.46,
      'gee:estimated_range': true,
    },
    Lwnet_tavg: {
      minimum: -359.07,
      maximum: 130.59,
      'gee:estimated_range': true,
    },
    PotEvap_tavg: {
      minimum: -241.88,
      maximum: 1513.78,
      'gee:estimated_range': true,
    },
    Psurf_f_inst: {
      minimum: 47824.13,
      maximum: 109036.41,
      'gee:estimated_range': true,
    },
    Qair_f_inst: {
      minimum: 0.0,
      maximum: 0.06,
      'gee:estimated_range': true,
    },
    Qg_tavg: {
      minimum: -517.58,
      maximum: 485.13,
      'gee:estimated_range': true,
    },
    Qh_tavg: {
      minimum: -872.46,
      maximum: 797.71,
      'gee:estimated_range': true,
    },
    Qle_tavg: {
      minimum: -243.71,
      maximum: 716.69,
      'gee:estimated_range': true,
    },
    Qs_acc: {
      minimum: 0.0,
      maximum: 131.39,
      'gee:estimated_range': true,
    },
    Qsb_acc: {
      minimum: 0.0,
      maximum: 42.3,
      'gee:estimated_range': true,
    },
    Qsm_acc: {
      minimum: 0.0,
      maximum: 27.58,
      'gee:estimated_range': true,
    },
    Rainf_f_tavg: {
      minimum: 0.0,
      maximum: 0.01,
      'gee:estimated_range': true,
    },
    Rainf_tavg: {
      minimum: 0.0,
      maximum: 0.01,
      'gee:estimated_range': true,
    },
    RootMoist_inst: {
      minimum: 2.0,
      maximum: 943.52,
      'gee:estimated_range': true,
    },
    SWE_inst: {
      minimum: 0.0,
      maximum: 117283.5,
      'gee:estimated_range': true,
    },
    SWdown_f_tavg: {
      minimum: 0.0,
      maximum: 1329.22,
      'gee:estimated_range': true,
    },
    SnowDepth_inst: {
      minimum: 0.0,
      maximum: 293.2,
      'gee:estimated_range': true,
    },
    Snowf_tavg: {
      minimum: 0.0,
      maximum: 0.004,
      'gee:estimated_range': true,
    },
    SoilMoi0_10cm_inst: {
      minimum: 1.99,
      maximum: 47.59,
      'gee:estimated_range': true,
    },
    SoilMoi10_40cm_inst: {
      minimum: 5.99,
      maximum: 142.8,
      'gee:estimated_range': true,
    },
    SoilMoi40_100cm_inst: {
      minimum: 11.99,
      maximum: 285.6,
      'gee:estimated_range': true,
    },
    SoilMoi100_200cm_inst: {
      minimum: 20.0,
      maximum: 476.0,
      'gee:estimated_range': true,
    },
    SoilTMP0_10cm_inst: {
      minimum: 218.75,
      maximum: 329.55,
      'gee:estimated_range': true,
    },
    SoilTMP10_40cm_inst: {
      minimum: 227.3,
      maximum: 317.08,
      'gee:estimated_range': true,
    },
    SoilTMP40_100cm_inst: {
      minimum: 232.59,
      maximum: 313.47,
      'gee:estimated_range': true,
    },
    SoilTMP100_200cm_inst: {
      minimum: 234.5,
      maximum: 311.86,
      'gee:estimated_range': true,
    },
    Swnet_tavg: {
      minimum: 0.0,
      maximum: 1128.86,
      'gee:estimated_range': true,
    },
    Tair_f_inst: {
      minimum: 197.03,
      maximum: 326.2,
      'gee:estimated_range': true,
    },
    Tveg_tavg: {
      minimum: 0.0,
      maximum: 611.89,
      'gee:estimated_range': true,
    },
    Wind_f_inst: {
      minimum: 0.06,
      maximum: 30.31,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Rodell, M., P.R. Houser, U. Jambor, J. Gottschalck, K. Mitchell,
    C.-J. Meng, K. Arsenault, B. Cosgrove, J. Radakovich, M. Bosilovich,
    J.K. Entin, J.P. Walker, D. Lohmann, and D. Toll, The Global Land Data
    Assimilation System, Bull. Amer. Meteor. Soc., 85(3), 381-394, 2004.
  |||,
  'sci:publications': [
    {
      citation: '[Additional references](https://ldas.gsfc.nasa.gov/gldas/GLDASpublications.php)',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
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
