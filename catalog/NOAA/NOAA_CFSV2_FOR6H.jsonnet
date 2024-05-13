local id = 'NOAA/CFSV2/FOR6H';
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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'CFSV2: NCEP Climate Forecast System Version 2, 6-Hourly Products',
  version: 'V2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The National Centers for Environmental Prediction (NCEP) Climate Forecast
    System (CFS) is a fully coupled model representing the interaction between
    the Earth's atmosphere, oceans, land, and sea ice. CFS was developed at the
    Environmental Modeling Center (EMC) at NCEP. The operational CFS was
    upgraded to version 2 (CFSv2) on March 30, 2011.

    Forecasts are initialized four times per day (0000, 0600, 1200, and 1800
    UTC). This is the same model that was used to create the NCEP Climate
    Forecast System Reanalysis (CFSR), and the purpose of the CFSv2 dataset is
    to extend CFSR. We ingest only a subset of bands from files matching
    cdas1.t??z.sfluxgrbf**06**.grib2.

    For more information about CFS, please see the [CFS NOAA site](https://cfs.ncep.noaa.gov/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5065/D61C1TXF',
    },
  ],
  keywords: [
    'climate',
    'daylight',
    'flux',
    'forecast',
    'geophysical',
    'ncep',
    'noaa',
    'nws',
    'precipitation',
    'radiation',
    'snow',
    'temperature',
    'vapor',
    'water',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA NWS National Centers for Environmental Prediction (NCEP)', 'https://cfs.ncep.noaa.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1979-01-01T00:00:00Z', null),
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
      22264.0,
    ],
    'eo:bands': [
      {
        name: 'Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average',
        description: 'Downward long-wave radiation flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Downward_Short-Wave_Radiation_Flux_surface_6_Hour_Average',
        description: 'Downward short-wave radiation flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Geopotential_height_surface',
        description: 'Geopotential height at surface',
        'gee:units': 'gpm',
      },
      {
        name: 'Latent_heat_net_flux_surface_6_Hour_Average',
        description: 'Latent heat net flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Maximum_specific_humidity_at_2m_height_above_ground_6_Hour_Interval',
        description: 'Maximum specific humidity 2m above ground, 6-hour interval',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Maximum_temperature_height_above_ground_6_Hour_Interval',
        description: 'Maximum temperature 2m above ground, 6-hour interval',
        'gee:units': units.kelvin,
      },
      {
        name: 'Minimum_specific_humidity_at_2m_height_above_ground_6_Hour_Interval',
        description: 'Minimum specific humidity 2m above ground, 6-hour interval',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Minimum_temperature_height_above_ground_6_Hour_Interval',
        description: 'Minimum temperature 2m above ground, 6-hour interval',
        'gee:units': units.kelvin,
      },
      {
        name: 'Potential_Evaporation_Rate_surface_6_Hour_Average',
        description: 'Potential evaporation rate at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Precipitation_rate_surface_6_Hour_Average',
        description: 'Precipitation rate at surface, 6-hour average',
        'gee:units': units.rainfall_rate_kg_per_m2_per_s,
      },
      {
        name: 'Pressure_surface',
        description: 'Pressure at surface',
        'gee:units': units.pascal,
      },
      {
        name: 'Sensible_heat_net_flux_surface_6_Hour_Average',
        description: 'Sensible heat net flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Specific_humidity_height_above_ground',
        description: 'Specific humidity 2m above ground',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'Temperature_height_above_ground',
        description: 'Temperature 2m above ground',
        'gee:units': units.kelvin,
      },
      {
        name: 'u-component_of_wind_height_above_ground',
        description: 'U-component of wind 10m above ground',
        'gee:units': units.velocity_si,
      },
      {
        name: 'Upward_Long-Wave_Radp_Flux_surface_6_Hour_Average',
        description: 'Upward long-wave radiation flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'Upward_Short-Wave_Radiation_Flux_surface_6_Hour_Average',
        description: 'Upward short-wave radiation flux at surface, 6-hour average',
        'gee:units': units.watt_per_meter_squared,
      },
      {
        name: 'v-component_of_wind_height_above_ground',
        description: 'V-component of wind 10m above ground',
        'gee:units': units.velocity_si,
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_5_cm',
        description: 'Volumetric soil moisture content 5cm below surface layer',
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_25_cm',
        description: 'Volumetric soil moisture content 25cm below surface layer',
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_70_cm',
        description: 'Volumetric soil moisture content 70cm below surface layer',
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_150_cm',
        description: 'Volumetric soil moisture content 150cm below surface layer',
        'gee:units': units.unspecified_fraction,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature Above Ground',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              220.0,
            ],
            max: [
              310.0,
            ],
            palette: [
              'blue',
              'purple',
              'cyan',
              'green',
              'yellow',
              'red',
            ],
            bands: [
              'Temperature_height_above_ground',
            ],
          },
        },
      },
    ],
    'Downward_Long-Wave_Radp_Flux_surface_6_Hour_Average': {
      minimum: 41.76,
      maximum: 532.67,
      'gee:estimated_range': true,
    },
    'Downward_Short-Wave_Radiation_Flux_surface_6_Hour_Average': {
      minimum: 0.0,
      maximum: 1125.23,
      'gee:estimated_range': true,
    },
    Geopotential_height_surface: {
      minimum: -292.0,
      maximum: 5938.65,
      'gee:estimated_range': true,
    },
    Latent_heat_net_flux_surface_6_Hour_Average: {
      minimum: -628.0,
      maximum: 2357.0,
      'gee:estimated_range': true,
    },
    Maximum_specific_humidity_at_2m_height_above_ground_6_Hour_Interval: {
      minimum: 0.0,
      maximum: 0.1,
      'gee:estimated_range': true,
    },
    Maximum_temperature_height_above_ground_6_Hour_Interval: {
      minimum: 189.8,
      maximum: 334.89,
      'gee:estimated_range': true,
    },
    Minimum_specific_humidity_at_2m_height_above_ground_6_Hour_Interval: {
      minimum: 0.0,
      maximum: 0.02,
      'gee:estimated_range': true,
    },
    Minimum_temperature_height_above_ground_6_Hour_Interval: {
      minimum: 188.39,
      maximum: 324.39,
      'gee:estimated_range': true,
    },
    Potential_Evaporation_Rate_surface_6_Hour_Average: {
      minimum: -202.0,
      maximum: 6277.0,
      'gee:estimated_range': true,
    },
    Precipitation_rate_surface_6_Hour_Average: {
      minimum: 0.0,
      maximum: 0.03,
      'gee:estimated_range': true,
    },
    Pressure_surface: {
      minimum: 47200.0,
      maximum: 109180.0,
      'gee:estimated_range': true,
    },
    Sensible_heat_net_flux_surface_6_Hour_Average: {
      minimum: -2295.0,
      maximum: 3112.0,
      'gee:estimated_range': true,
    },
    Specific_humidity_height_above_ground: {
      minimum: 0.0,
      maximum: 0.06,
      'gee:estimated_range': true,
    },
    Temperature_height_above_ground: {
      minimum: 188.96,
      maximum: 328.68,
      'gee:estimated_range': true,
    },
    'u-component_of_wind_height_above_ground': {
      minimum: -57.2,
      maximum: 57.99,
      'gee:estimated_range': true,
    },
    'Upward_Long-Wave_Radp_Flux_surface_6_Hour_Average': {
      minimum: 59.0,
      maximum: 757.0,
      'gee:estimated_range': true,
    },
    'Upward_Short-Wave_Radiation_Flux_surface_6_Hour_Average': {
      minimum: 0.0,
      maximum: 812.0,
      'gee:estimated_range': true,
    },
    'v-component_of_wind_height_above_ground': {
      minimum: -53.09,
      maximum: 57.11,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_5_cm: {
      minimum: 0.02,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_25_cm: {
      minimum: 0.02,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_70_cm: {
      minimum: 0.02,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_150_cm: {
      minimum: 0.02,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5065/D61C1TXF',
  'sci:citation': |||
    Saha, S., et al. 2011, updated daily. NCEP Climate Forecast System
    Version 2 (CFSv2) 6-hourly Products. Research Data Archive at the National
    Center for Atmospheric Research, Computational and Information Systems
    Laboratory. [https://doi.org/10.5065/D61C1TXF](https://doi.org/10.5065/D61C1TXF).
    Accessed dd mmm yyyy.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 6,
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution. For more information visit the
    [NWS disclaimer site](https://www.weather.gov/disclaimer/).
  |||,
}
