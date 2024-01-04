local id = 'NASA/GLDAS/V021/NOAH/G025/T3H';
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
  title: 'GLDAS-2.1: Global Land Data Assimilation System',
  version: 'V021',
  'gee:type': ee_const.gee_type.image_collection,
  description: (importstr 'NASA_GLDAS_V2_description.md') + |||
    GLDAS-2.1 is one of two components of the GLDAS Version 2 (GLDAS-2) dataset,
    the second being GLDAS-2.0. GLDAS-2.1 is analogous to GLDAS-1 product stream,
    with upgraded models forced by a combination of [GDAS, disaggregated GPCP,
    and AGRMET radiation data sets](https://ldas.gsfc.nasa.gov/gldas/GLDASforcing.php).

    The GLDAS-2.1 simulation started on January 1, 2000 using the
    conditions from the GLDAS-2.0 simulation. This simulation was
    forced with National Oceanic and Atmospheric Administration
    (NOAA)/Global Data Assimilation System (GDAS) atmospheric analysis
    fields (Derber et al., 1991), the disaggregated Global Precipitation
    Climatology Project (GPCP) precipitation fields (Adler et al., 2003),
    and the Air Force Weather Agency's AGRicultural METeorological
    modeling system (AGRMET) radiation fields which became available
    for March 1, 2001 onwards.

    Documentation:

    * [Readme](https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_NOAH025_3H.2.1/doc/README_GLDAS2.pdf)

    * [How-to](https://disc.gsfc.nasa.gov/information/howto?tags=hydrology)

    * [GES DISC Hydrology Documentation](https://disc.gsfc.nasa.gov/information/documents?title=Hydrology%20Documentation)

    * [GES DISC Data Rods Documentation](https://disc.gsfc.nasa.gov/information/tools?title=Hydrology%20Data%20Rods)

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
    ee.producer_provider('NASA GES DISC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/E7TYRXPJKWOQ'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1342986035-GES_DISC',  // CMR concept id for final GLDAS data
    'C1700900626-GES_DISC',  // CMR concept id for early GLDAS data
  ],
  extent: ee.extent_global('2000-01-01T03:00:00Z', null),
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
      minimum: 187.48,
      maximum: 1323.35,
      'gee:estimated_range': true,
    },
    CanopInt_inst: {
      minimum: 0.0,
      maximum: 0.5,
      'gee:estimated_range': true,
    },
    ECanop_tavg: {
      minimum: 0.0,
      maximum: 1273.66,
      'gee:estimated_range': true,
    },
    ESoil_tavg: {
      minimum: 0.0,
      maximum: 2275.63,
      'gee:estimated_range': true,
    },
    Evap_tavg: {
      minimum: 0.0,
      maximum: 0.002,
      'gee:estimated_range': true,
    },
    LWdown_f_tavg: {
      minimum: 26.85,
      maximum: 600.9,
      'gee:estimated_range': true,
    },
    Lwnet_tavg: {
      minimum: -13792.7,
      maximum: 196.97,
      'gee:estimated_range': true,
    },
    PotEvap_tavg: {
      minimum: -227.75,
      maximum: 18977.87,
      'gee:estimated_range': true,
    },
    Psurf_f_inst: {
      minimum: 44063.08,
      maximum: 108343.92,
      'gee:estimated_range': true,
    },
    Qair_f_inst: {
      minimum: -0.02,
      maximum: 0.07,
      'gee:estimated_range': true,
    },
    Qg_tavg: {
      minimum: -552.64,
      maximum: 1538.41,
      'gee:estimated_range': true,
    },
    Qh_tavg: {
      minimum: -1005.15,
      maximum: 18190.63,
      'gee:estimated_range': true,
    },
    Qle_tavg: {
      minimum: -227.75,
      maximum: 5072.25,
      'gee:estimated_range': true,
    },
    Qs_acc: {
      minimum: 0.0,
      maximum: 170.93,
      'gee:estimated_range': true,
    },
    Qsb_acc: {
      minimum: 0.0,
      maximum: 50.6,
      'gee:estimated_range': true,
    },
    Qsm_acc: {
      minimum: 0.0,
      maximum: 42.87,
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
      maximum: 949.6,
      'gee:estimated_range': true,
    },
    SWE_inst: {
      minimum: 0.0,
      maximum: 120786.71,
      'gee:estimated_range': true,
    },
    SWdown_f_tavg: {
      minimum: -56.93,
      maximum: 30462.81,
      'gee:estimated_range': true,
    },
    SnowDepth_inst: {
      minimum: 0.0,
      maximum: 301.96,
      'gee:estimated_range': true,
    },
    Snowf_tavg: {
      minimum: 0.0,
      maximum: 0.009,
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
      minimum: 221.98,
      maximum: 377.5,
      'gee:estimated_range': true,
    },
    SoilTMP10_40cm_inst: {
      minimum: 227.43,
      maximum: 319.44,
      'gee:estimated_range': true,
    },
    SoilTMP40_100cm_inst: {
      minimum: 232.97,
      maximum: 316.2,
      'gee:estimated_range': true,
    },
    SoilTMP100_200cm_inst: {
      minimum: 238.52,
      maximum: 314.11,
      'gee:estimated_range': true,
    },
    Swnet_tavg: {
      minimum: -48.96,
      maximum: 23741.33,
      'gee:estimated_range': true,
    },
    Tair_f_inst: {
      minimum: 206.8,
      maximum: 327.66,
      'gee:estimated_range': true,
    },
    Tveg_tavg: {
      minimum: 0.0,
      maximum: 3455.14,
      'gee:estimated_range': true,
    },
    Wind_f_inst: {
      minimum: 0.0,
      maximum: 57.7,
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
