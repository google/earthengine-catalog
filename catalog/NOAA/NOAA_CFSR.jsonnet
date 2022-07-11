local id = 'NOAA/CFSR';
local subdir = 'NOAA';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'CFSR: Climate Forecast System Reanalysis',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The National Centers for Environmental Prediction (NCEP) Climate Forecast System Reanalysis
    (CFSR) was designed and executed as a global, high-resolution, coupled atmosphere-ocean-land
    surface-sea ice system to provide the best estimate of the state of these coupled domains over
    the 32-year period of record from January 1979 to March 2011. It has been extended as an
    operational real-time product. The data in Earth Engine are only present
    starting from December 13, 2018.

    Forecasts are initialized four times per day (0000, 0600, 1200, and 1800
    UTC). We ingest only a subset of bands from files matching
    cdas1.t??z.pgrbh**03|00**.grib2 i.e. files of only 0-hour and 3-hour forecasts as the others are
    omitted. The forecast length is indicated by the 'forecast_hour' metadata field.

    Some images contain only a subset of bands. Using this dataset with both \"00\" and \"03\" forecast
    types will require you to cast the bands across the collection.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5065/D6513W89',
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
    ee.producer_provider('NOAA NWS National Centers for Environmental Prediction (NCEP)', 'https://cfs.ncep.noaa.gov/cfsr/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-12-13T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'forecast_hour',
        description: 'Duration of forecast in hours',
        type: ee_const.var_type.int,
      },
    ],
    gsd: [
      55660.0,
    ],
    'eo:bands': [
      {
        name: 'u-component_of_wind_hybrid',
        description: 'u-component of wind at Hybrid level for 00 and 03 forecast',
        'gee:units': 'm/s',
      },
      {
        name: 'v-component_of_wind_hybrid',
        description: 'v-component of wind at Hybrid level for 00 and 03 forecast',
        'gee:units': 'm/s',
      },
      {
        name: 'Albedo_surface_3_Hour_Average',
        description: 'Albedo 3 hour average at ground or water surface for 03 forecast',
        'gee:units': '%',
      },
      {
        name: 'Canopy_water_evaporation_surface_3_Hour_Average',
        description: 'Canopy water evaporation 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Categorical_Rain_surface',
        description: 'Categorical Rain at ground or water surface for 00 and 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Categorical_Rain_surface_3_Hour_Average',
        description: 'Categorical Rain 3 hour average at ground or water surface for 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Categorical_Freezing_Rain_surface_3_Hour_Average',
        description: 'Categorical freezing rain 3 hour average at ground or water surface for 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Categorical_Ice_Pellets_surface_3_Hour_Average',
        description: 'Categorical ice pellets 3 hour average at ground or water surface for 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Categorical_Snow_surface_3_Hour_Average',
        description: 'Categorical snow 3 hour average at ground or water surface for 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Clear_Sky_Downward_Long_Wave_Flux_surface_3_Hour_Average',
        description: 'Clear Sky Downward Long Wave Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Clear_Sky_Downward_Solar_Flux_surface_3_Hour_Average',
        description: 'Clear Sky Downward Solar Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Clear_Sky_Upward_Long_Wave_Flux_surface_3_Hour_Average',
        description: 'Clear Sky Upward Long Wave Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Clear_Sky_Upward_Solar_Flux_atmosphere_top_3_Hour_Average',
        description: 'Clear Sky Upward Solar Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Clear_sky_UV-B_Downward_Solar_Flux_surface_3_Hour_Average',
        description: 'Clear Sky UV-B Downward Solar Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Cloud_water_entire_atmosphere_single_layer',
        description: 'Cloud water at entire atmosphere layer for 00 and 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Cloud_Work_Function_entire_atmosphere_single_layer_3_Hour_Average',
        description: 'Cloud work function 3 hour average at entire atmosphere layer for 03 forecast',
        'gee:units': 'J/kg',
      },
      {
        name: 'Convective_available_potential_energy_surface',
        description: 'Convective available potential energy at ground or water surface for 00 and 03 forecast',
        'gee:units': 'J/kg',
      },
      {
        name: 'Convective_available_potential_energy_pressure_difference_layer',
        description: |||
          Convective available potential energy at specified pressure difference from
          ground to level layer for 03 forecast
        |||,
        'gee:units': 'J/kg',
      },
      {
        name: 'Convective_Precipitation_Rate_surface_3_Hour_Average',
        description: 'Convective precipitation rate 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'kg/(m^2/s)',
      },
      {
        name: 'Convective_precipitation_surface_3_Hour_Accumulation',
        description: 'Convective precipitation 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Direct_Evaporation_from_Bare_Soil_surface_3_Hour_Average',
        description: 'Direct evaporation from bare soil surface 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Downward_Long-Wave_Radp_Flux_surface',
        description: 'Downward Long-Wave Rad. Flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Downward_Long-Wave_Radp_Flux_surface_3_Hour_Average',
        description: 'Downward Long-Wave Rad. Flux  3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Downward_Short-Wave_Radiation_Flux_surface',
        description: 'Downward Short-Wave Radiation Flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Downward_Short-Wave_Radiation_Flux_surface_3_Hour_Average',
        description: 'Downward Short-Wave Radiation Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Downward_Short-Wave_Radiation_Flux_atmosphere_top_3_Hour_Average',
        description: |||
          Downward Short-Wave Radiation Flux atmosphere top 3 hour average at
          ground or water surface for 03 forecast
        |||,
        'gee:units': 'W/m^2',
      },
      {
        name: 'Exchange_Coefficient_surface',
        description: 'Exchange Coefficient at ground or water surface for 00 and 03 forecast',
        'gee:units': '(kg/m^3)/(m/s)',
      },
      {
        name: 'Frictional_Velocity_surface',
        description: 'Frictional Velocity at ground or water surface for 00 and 03 forecast',
        'gee:units': 'm/s',
      },
      {
        name: 'Ground_Heat_Flux_surface',
        description: 'Ground Heat Flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Ground_Heat_Flux_surface_3_Hour_Average',
        description: 'Ground Heat Flux 4 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Ice_cover_surface',
        description: 'Ice cover at ground or water surface for 00 and 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Ice_thickness_surface',
        description: 'Ice thickness at ground or water surface for 00 and 03 forecast',
        'gee:units': 'm',
      },
      {
        name: 'Land_cover_0__sea_1__land_surface',
        description: 'Land cover (0 = sea, 1 = land) at ground or water surface for 00 and 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Latent_heat_net_flux_surface',
        description: 'Latent heat net flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Latent_heat_net_flux_surface_3_Hour_Average',
        description: 'Latent heat net flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_5_cm',
        description: 'Liquid Volumetric Soil Moisture (non Frozen) 5 cm depth below land surface layer',
        // TODO: This is a type.  'gee:units': 'DOUBLE',
      },
      {
        name: 'Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_25_cm',
        description: 'Liquid Volumetric Soil Moisture (non Frozen) 25 cm depth below land surface layer',
        // TODO: This is a type.  'gee:units': 'DOUBLE',
      },
      {
        name: 'Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_70_cm',
        description: 'Liquid Volumetric Soil Moisture (non Frozen) 50 cm depth below land surface layer',
        // TODO: This is a type.  'gee:units': 'DOUBLE',
      },
      {
        name: 'Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_150_cm',
        description: 'Liquid Volumetric Soil Moisture (non Frozen) 150 cm depth below land surface layer',
        // TODO: This is a type.  'gee:units': 'DOUBLE',
      },
      {
        name: 'Maximum_temperature_height_above_ground_3_Hour_Interval',
        description: 'Maximum temperature for 3 Hour Interval at specified height level above ground for 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Minimum_temperature_height_above_ground_3_Hour_Interval',
        description: 'Minimum temperature for 3 Hour Interval at specified height level above ground for 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Maximum_specific_humidity_at_2m_height_above_ground_3_Hour_Interval',
        description: 'Maximum specific humidity for 3 Hour Interval at 2m specified height level above ground for 03 forecast',
        'gee:units': 'kg/kg',
      },
      {
        name: 'Minimum_specific_humidity_at_2m_height_above_ground_3_Hour_Interval',
        description: 'Minimum specific humidity for 3 Hour Interval at 2m specified height level above ground for 03 forecast',
        'gee:units': 'kg/kg',
      },
      {
        name: 'Momentum_flux_u-component_surface_3_Hour_Average',
        description: 'Momentum flux, u-component 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'N/m^2',
      },
      {
        name: 'Momentum_flux_v-component_surface_3_Hour_Average',
        description: 'Momentum flux, u-component 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'N/m^2',
      },
      {
        name: 'Plant_Canopy_Surface_Water_surface',
        description: 'Plant Canopy Surface Water at ground or water surface for 00 and 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Planetary_Boundary_Layer_Height_surface',
        description: 'Planetary Boundary Layer Height at ground or water surface for 00 and 03 forecast',
        'gee:units': 'm',
      },
      {
        name: 'Potential_Evaporation_Rate_surface',
        description: 'Potential Evaporation Rate at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Potential_Evaporation_Rate_surface_3_Hour_Average',
        description: 'Potential Evaporation Rate 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Precipitation_rate_surface_3_Hour_Average',
        description: 'Precipitable rate 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'kg/m^2s',
      },
      {
        name: 'Precipitable_water_entire_atmosphere_single_layer',
        description: 'Precipitable water at entire atmosphere layer for 00 and 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Precipitable_water_pressure_difference_layer',
        description: 'Precipitable water at specified pressure difference from ground to level layer for 00 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Pressure_msl',
        description: 'Pressure at Mean sea level for 03 forecast',
        'gee:units': 'Pa',
      },
      {
        name: 'Pressure_reduced_to_MSL_msl',
        description: 'Pressure reduced to MSL at Mean sea level for 00 and 03 forecast',
        'gee:units': 'Pa',
      },
      {
        name: 'Pressure_surface',
        description: 'Pressure at ground or water surface for 00 and 03 forecast',
        'gee:units': 'Pa',
      },
      {
        name: 'Relative_humidity_entire_atmosphere_single_layer',
        description: 'Relative humidity at entire atmosphere layer for 00 and 03 forecast',
        'gee:units': '%',
      },
      {
        name: 'Sensible_heat_net_flux_surface',
        description: 'Sensible heat net flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Sensible_heat_net_flux_surface_3_Hour_Average',
        description: 'Sensible heat net flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Snow_Cover_surface_3_Hour_Average',
        description: 'Snow cover 3 hour average at ground or water surface for 03 forecast',
        'gee:units': '%',
      },
      {
        name: 'Snow_depth_surface',
        description: 'Snow depth at ground or water surface for 00 and 03 forecast',
        'gee:units': 'm',
      },
      {
        name: 'Snow_Phase_Change_Heat_Flux_surface_3_Hour_Average',
        description: 'Snow phase change hear flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Soil_moisture_content_depth_below_surface_layer',
        description: 'Soil moisture content at Depth below land surface layer for 00 and 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Soil_type_surface',
        description: 'Soil type at ground or water surface for 00 and 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Storm_Surface_Runoff_surface_3_Hour_Accumulation',
        description: 'Strom surface runoff 3 hour accumulation at ground or water surface for 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Sublimation_evaporation_from_snow_surface_3_Hour_Average',
        description: 'Sublimation (evaporation from snow) 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Specific_humidity_height_above_ground',
        description: 'Specific humidity at Specified height level above ground for 00 forecast',
        'gee:units': 'kg/kg',
      },
      {
        name: 'Surface_Lifted_Index_surface',
        description: 'Surface Lifted Index at ground or water surface for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Surface_roughness_surface',
        description: 'Surface roughness at ground or water surface for 00 and 03 forecast',
        'gee:units': 'm',
      },
      {
        name: 'Surface_Slope_Type_surface',
        description: 'Surface Slope Type at ground or water surface for 00 and 03 forecast',
        'gee:units': 'index',
      },
      {
        name: 'Temperature_depth_below_surface_layer_5_cm',
        description: 'Temperature 5cm depth below land surface layer for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Temperature_depth_below_surface_layer_25_cm',
        description: 'Temperature 25cm epth below land surface layer for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Temperature_depth_below_surface_layer_70_cm',
        description: 'Temperature 70 cm depth below land surface layer for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Temperature_depth_below_surface_layer_150_cm',
        description: 'Temperature 150cm depth below land surface layer for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Temperature_height_above_ground',
        description: 'Temperature at Specified height level above ground for 00 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Temperature_surface',
        description: 'Temperature at ground or water surface for 00 and 03 forecast',
        'gee:units': 'K',
      },
      {
        name: 'Total_cloud_cover_convective_cloud',
        description: 'Total cloud cover at Convective cloud layer for 00 forecast',
        'gee:units': '%',
      },
      {
        name: 'Total_ozone_entire_atmosphere_single_layer',
        description: 'Total ozone at entire atmosphere layer for 00 and 03 forecast',
        'gee:units': 'DU',
      },
      {
        name: 'Total_precipitation_surface_3_Hour_Accumulation',
        description: 'Total precipitation 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Transpiration_surface_3_Hour_Average',
        description: 'Transpiration surface 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Long-Wave_Radp_Flux_surface',
        description: 'Upward Long-Wave Rad. Flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Long-Wave_Radp_Flux_surface_3_Hour_Average',
        description: 'Upward Long-Wave Radiation Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Long-Wave_Radp_Flux_atmosphere_top_3_Hour_Average',
        description: 'Upward Long-Wave Radiation Flux 3 hour average at nominal top of the atmosphere for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Short-Wave_Radiation_Flux_surface',
        description: 'Upward Short-Wave Radiation Flux at ground or water surface for 00 and 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Short-Wave_Radiation_Flux_surface_3_Hour_Average',
        description: 'Upward Short-Wave Radiation Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Upward_Short-Wave_Radiation_Flux_atmosphere_top_3_Hour_Average',
        description: 'Upward Short-Wave Radiation Flux 3 hour average at nominal top of the atmosphere for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'UV-B_Downward_Solar_Flux_surface_3_Hour_Average',
        description: 'UV-B Downward Solar Flux 3 hour average at ground or water surface for 03 forecast',
        'gee:units': 'W/m^2',
      },
      {
        name: 'Vegetation_surface',
        description: 'Vegetation at ground or water surface for 00 and 03 forecast',
        'gee:units': '%',
      },
      {
        name: 'Vegetation_Type_surface',
        description: 'Vegetation Type at ground or water surface for 00 and 03 forecast',
        // TODO: This is a type.  'gee:units': 'INT',
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_5_cm',
        description: 'Volumetric soil moisture content 5cm below surface layer for 00 and 03 forecast',
        'gee:units': 'fraction',
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_25_cm',
        description: 'Volumetric soil moisture content 25cm below surface layer for 00 and 03 forecast',
        'gee:units': 'fraction',
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_70_cm',
        description: 'Volumetric soil moisture content 70cm below surface layer for 00 and 03 forecast',
        'gee:units': 'fraction',
      },
      {
        name: 'Volumetric_Soil_Moisture_Content_depth_below_surface_layer_150_cm',
        description: 'Volumetric soil moisture content 150cm below surface layer for 00 and 03 forecast',
        'gee:units': 'fraction',
      },
      {
        name: 'Water_equivalent_of_accumulated_snow_depth_surface',
        description: 'Water equivalent of accumulated snow depth at ground or water surface for 00 and 03 forecast',
        'gee:units': 'kg/m^2',
      },
      {
        name: 'Water_runoff_surface_3_Hour_Accumulation',
        description: 'Water runoff 3 hour accumulation at ground or water surface for 03 forecast',
        'gee:units': 'kg/m^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature Surface',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              192.0,
            ],
            max: [
              339.0,
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
              'Temperature_surface',
            ],
          },
        },
      },
    ],
    'u-component_of_wind_hybrid': {
      minimum: -47.24,
      maximum: 44.33,
      'gee:estimated_range': true,
    },
    'v-component_of_wind_hybrid': {
      minimum: -45.45,
      maximum: 46.36,
      'gee:estimated_range': true,
    },
    Albedo_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 91.59999847,
      'gee:estimated_range': true,
    },
    Canopy_water_evaporation_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 746.0,
      'gee:estimated_range': true,
    },
    Categorical_Rain_surface: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Categorical_Rain_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Categorical_Freezing_Rain_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Categorical_Ice_Pellets_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Categorical_Snow_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Clear_Sky_Downward_Long_Wave_Flux_surface_3_Hour_Average: {
      minimum: 56.0,
      maximum: 483.0,
      'gee:estimated_range': true,
    },
    Clear_Sky_Downward_Solar_Flux_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 1142.0,
      'gee:estimated_range': true,
    },
    Clear_Sky_Upward_Long_Wave_Flux_surface_3_Hour_Average: {
      minimum: 78.0,
      maximum: 698.0,
      'gee:estimated_range': true,
    },
    Clear_Sky_Upward_Solar_Flux_atmosphere_top_3_Hour_Average: {
      minimum: 0.0,
      maximum: 767.0,
      'gee:estimated_range': true,
    },
    'Clear_sky_UV-B_Downward_Solar_Flux_surface_3_Hour_Average': {
      minimum: 0.0,
      maximum: 24.77,
      'gee:estimated_range': true,
    },
    Cloud_water_entire_atmosphere_single_layer: {
      minimum: 0.0,
      maximum: 19.0,
      'gee:estimated_range': true,
    },
    Cloud_Work_Function_entire_atmosphere_single_layer_3_Hour_Average: {
      minimum: 0.0,
      maximum: 5791.0,
      'gee:estimated_range': true,
    },
    Convective_available_potential_energy_surface: {
      minimum: 0.0,
      maximum: 6069.0,
      'gee:estimated_range': true,
    },
    Convective_available_potential_energy_pressure_difference_layer: {
      minimum: 0.0,
      maximum: 5559.0,
      'gee:estimated_range': true,
    },
    Convective_Precipitation_Rate_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 0.002,
      'gee:estimated_range': true,
    },
    Convective_precipitation_surface_3_Hour_Accumulation: {
      minimum: 0.0,
      maximum: 19.2,
      'gee:estimated_range': true,
    },
    Direct_Evaporation_from_Bare_Soil_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 767.0,
      'gee:estimated_range': true,
    },
    'Downward_Long-Wave_Radp_Flux_surface': {
      minimum: 60.0,
      maximum: 530.0,
      'gee:estimated_range': true,
    },
    'Downward_Long-Wave_Radp_Flux_surface_3_Hour_Average': {
      minimum: 60.0,
      maximum: 508.0,
      'gee:estimated_range': true,
    },
    'Downward_Short-Wave_Radiation_Flux_surface': {
      minimum: 0.0,
      maximum: 1224.0,
      'gee:estimated_range': true,
    },
    'Downward_Short-Wave_Radiation_Flux_surface_3_Hour_Average': {
      minimum: 0.0,
      maximum: 1142.0,
      'gee:estimated_range': true,
    },
    'Downward_Short-Wave_Radiation_Flux_atmosphere_top_3_Hour_Average': {
      minimum: 0.0,
      maximum: 1382.0,
      'gee:estimated_range': true,
    },
    Exchange_Coefficient_surface: {
      minimum: 0.0,
      maximum: 0.69,
      'gee:estimated_range': true,
    },
    Frictional_Velocity_surface: {
      minimum: 0.002,
      maximum: 3.5,
      'gee:estimated_range': true,
    },
    Ground_Heat_Flux_surface: {
      minimum: -459.0,
      maximum: 683.0,
      'gee:estimated_range': true,
    },
    Ground_Heat_Flux_surface_3_Hour_Average: {
      minimum: -170.0,
      maximum: 538.0,
      'gee:estimated_range': true,
    },
    Ice_cover_surface: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Ice_thickness_surface: {
      minimum: 0.0,
      maximum: 4.76,
      'gee:estimated_range': true,
    },
    Land_cover_0__sea_1__land_surface: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Latent_heat_net_flux_surface: {
      minimum: -399.0,
      maximum: 1675.0,
      'gee:estimated_range': true,
    },
    Latent_heat_net_flux_surface_3_Hour_Average: {
      minimum: -305.0,
      maximum: 1250.0,
      'gee:estimated_range': true,
    },
    Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_5_cm: {
      minimum: 0.03,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_25_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_70_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Liquid_Volumetric_Soil_Moisture_non_Frozen_depth_below_surface_layer_150_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Maximum_temperature_height_above_ground_3_Hour_Interval: {
      minimum: 201.39,
      maximum: 327.7,
      'gee:estimated_range': true,
    },
    Minimum_temperature_height_above_ground_3_Hour_Interval: {
      minimum: 201.0,
      maximum: 321.89,
      'gee:estimated_range': true,
    },
    Maximum_specific_humidity_at_2m_height_above_ground_3_Hour_Interval: {
      minimum: 0.0,
      maximum: 0.036,
      'gee:estimated_range': true,
    },
    Minimum_specific_humidity_at_2m_height_above_ground_3_Hour_Interval: {
      minimum: 0.0,
      maximum: 0.024,
      'gee:estimated_range': true,
    },
    'Momentum_flux_u-component_surface_3_Hour_Average': {
      minimum: -6.56,
      maximum: 8.25,
      'gee:estimated_range': true,
    },
    'Momentum_flux_v-component_surface_3_Hour_Average': {
      minimum: -6.17,
      maximum: 7.22,
      'gee:estimated_range': true,
    },
    Plant_Canopy_Surface_Water_surface: {
      minimum: 0.0,
      maximum: 0.5,
      'gee:estimated_range': true,
    },
    Planetary_Boundary_Layer_Height_surface: {
      minimum: 17.0,
      maximum: 6590.0,
      'gee:estimated_range': true,
    },
    Potential_Evaporation_Rate_surface: {
      minimum: -150.0,
      maximum: 5617.0,
      'gee:estimated_range': true,
    },
    Potential_Evaporation_Rate_surface_3_Hour_Average: {
      minimum: -120.0,
      maximum: 5263.0,
      'gee:estimated_range': true,
    },
    Precipitation_rate_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 0.022,
      'gee:estimated_range': true,
    },
    Precipitable_water_entire_atmosphere_single_layer: {
      minimum: -0.6,
      maximum: 99.09,
      'gee:estimated_range': true,
    },
    Precipitable_water_pressure_difference_layer: {
      minimum: 0.0,
      maximum: 7.94,
      'gee:estimated_range': true,
    },
    Pressure_msl: {
      minimum: 92406.39,
      maximum: 106907.89,
      'gee:estimated_range': true,
    },
    Pressure_reduced_to_MSL_msl: {
      minimum: 92492.8,
      maximum: 106667.79,
      'gee:estimated_range': true,
    },
    Pressure_surface: {
      minimum: 48110.0,
      maximum: 105600.0,
      'gee:estimated_range': true,
    },
    Relative_humidity_entire_atmosphere_single_layer: {
      minimum: 0.0,
      maximum: 96.0,
      'gee:estimated_range': true,
    },
    Sensible_heat_net_flux_surface: {
      minimum: -1582.0,
      maximum: 2500.0,
      'gee:estimated_range': true,
    },
    Sensible_heat_net_flux_surface_3_Hour_Average: {
      minimum: -977.0,
      maximum: 1202.0,
      'gee:estimated_range': true,
    },
    Snow_Cover_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    Snow_depth_surface: {
      minimum: 0.0,
      maximum: 4.55,
      'gee:estimated_range': true,
    },
    Snow_Phase_Change_Heat_Flux_surface_3_Hour_Average: {
      minimum: -405.0,
      maximum: 911.0,
      'gee:estimated_range': true,
    },
    Soil_moisture_content_depth_below_surface_layer: {
      minimum: 62.01,
      maximum: 2000.05,
      'gee:estimated_range': true,
    },
    Soil_type_surface: {
      minimum: 1.0,
      maximum: 9.0,
      'gee:estimated_range': true,
    },
    Storm_Surface_Runoff_surface_3_Hour_Accumulation: {
      minimum: 0.0,
      maximum: 193.12,
      'gee:estimated_range': true,
    },
    Sublimation_evaporation_from_snow_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 742.0,
      'gee:estimated_range': true,
    },
    Specific_humidity_height_above_ground: {
      minimum: 0.001,
      maximum: 0.036,
      'gee:estimated_range': true,
    },
    Surface_Lifted_Index_surface: {
      minimum: -15.8,
      maximum: 57.2,
      'gee:estimated_range': true,
    },
    Surface_roughness_surface: {
      minimum: 0.0,
      maximum: 2.7,
      'gee:estimated_range': true,
    },
    Surface_Slope_Type_surface: {
      minimum: 1.0,
      maximum: 9.0,
      'gee:estimated_range': true,
    },
    Temperature_depth_below_surface_layer_5_cm: {
      minimum: 219.127,
      maximum: 323.104,
      'gee:estimated_range': true,
    },
    Temperature_depth_below_surface_layer_25_cm: {
      minimum: 220.288,
      maximum: 313.299,
      'gee:estimated_range': true,
    },
    Temperature_depth_below_surface_layer_70_cm: {
      minimum: 218.704,
      maximum: 310.007,
      'gee:estimated_range': true,
    },
    Temperature_depth_below_surface_layer_150_cm: {
      minimum: 218.925,
      maximum: 307.662,
      'gee:estimated_range': true,
    },
    Temperature_height_above_ground: {
      minimum: 201.17,
      maximum: 325.763,
      'gee:estimated_range': true,
    },
    Temperature_surface: {
      minimum: 192.569,
      maximum: 339.173,
      'gee:estimated_range': true,
    },
    Total_cloud_cover_convective_cloud: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    Total_ozone_entire_atmosphere_single_layer: {
      minimum: 177.0,
      maximum: 571.4,
      'gee:estimated_range': true,
    },
    Total_precipitation_surface_3_Hour_Accumulation: {
      minimum: 0.0,
      maximum: 239.0,
      'gee:estimated_range': true,
    },
    Transpiration_surface_3_Hour_Average: {
      minimum: 0.0,
      maximum: 680.0,
      'gee:estimated_range': true,
    },
    'Upward_Long-Wave_Radp_Flux_surface': {
      minimum: 135.0,
      maximum: 611.0,
      'gee:estimated_range': true,
    },
    'Upward_Long-Wave_Radp_Flux_surface_3_Hour_Average': {
      minimum: 78.0,
      maximum: 703.0,
      'gee:estimated_range': true,
    },
    'Upward_Long-Wave_Radp_Flux_atmosphere_top_3_Hour_Average': {
      minimum: 69.0,
      maximum: 384.0,
      'gee:estimated_range': true,
    },
    'Upward_Short-Wave_Radiation_Flux_surface': {
      minimum: 0.0,
      maximum: 869.0,
      'gee:estimated_range': true,
    },
    'Upward_Short-Wave_Radiation_Flux_surface_3_Hour_Average': {
      minimum: 0.0,
      maximum: 806.0,
      'gee:estimated_range': true,
    },
    'Upward_Short-Wave_Radiation_Flux_atmosphere_top_3_Hour_Average': {
      minimum: 0.0,
      maximum: 1049.0,
      'gee:estimated_range': true,
    },
    'UV-B_Downward_Solar_Flux_surface_3_Hour_Average': {
      minimum: 0.0,
      maximum: 24.7,
      'gee:estimated_range': true,
    },
    Vegetation_surface: {
      minimum: 0.0,
      maximum: 99.0,
      'gee:estimated_range': true,
    },
    Vegetation_Type_surface: {
      minimum: 1.0,
      maximum: 13.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_5_cm: {
      minimum: 0.03,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_25_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_70_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Volumetric_Soil_Moisture_Content_depth_below_surface_layer_150_cm: {
      minimum: 0.028,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
    Water_equivalent_of_accumulated_snow_depth_surface: {
      minimum: 0.0,
      maximum: 458.82,
      'gee:estimated_range': true,
    },
    Water_runoff_surface_3_Hour_Accumulation: {
      minimum: 0.0,
      maximum: 193.12,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5065/D6513W89',
  'sci:citation': |||
    Saha, S., S. Moorthi, H. Pan, X. Wu, J. Wang, and Coauthors, 2010: The NCEP Climate
    Forecast System Reanalysis. Bulletin of the American Meteorological Society, 91, 1015–1057.
    [doi:10.1175/2010BAMS3001.1](https://doi.org/10.1175/2010BAMS3001.1)
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
