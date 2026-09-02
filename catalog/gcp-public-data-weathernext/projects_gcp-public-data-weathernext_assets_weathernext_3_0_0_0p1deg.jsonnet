local id = 'projects/gcp-public-data-weathernext/assets/weathernext_3_0_0_0p1deg';
local subdir = 'gcp-public-data-weathernext';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

local license = spdx.proprietary;

{
  // TODO(mahrsee): Remove when the dataset is ready.
  // TODO(mahrsee): Add the collection here: geo/gestalt/data/catalog/testdata/public_datasets.txt
  'gee:status': 'incomplete',
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'WeatherNext 3 (0.1&deg;)',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This placeholder text will be replaced with final content later on.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: [
    'weather',
    'weathernext',
    'forecast',
    'temperature',
    'precipitation',
    'wind',
  ],
  providers: [
    ee.producer_provider('Google', 'https://developers.google.com/weathernext'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2026-01-01T00:00:00Z', null),
  summaries: {
    gsd: [11132],
    'gee:schema': [
      {
        name: 'start_time',
        description: |||
          The initialization time of the forecast. This is the same for all
          forecast hours within a single model run.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'end_time',
        description: |||
          The valid time for this specific forecast. Calculated as
          start_time + forecast_hour.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'forecast_hour',
        description: |||
          The forecast lead time in hours. Represents the number of hours from
          the start_time.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ingestion_time_utc',
        description: |||
          The time when this forecast data became available in Earth Engine.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'B_',
        description: |||
          The band names in the order, starting from B0 to B113.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'eo:bands': [
      {
        name: 'dewpoint_temperature_2m_mean',
        description: |||
          Mean of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'dewpoint_temperature_2m_p10',
        description: |||
          10th percentile of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'dewpoint_temperature_2m_p25',
        description: |||
          25th percentile of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'dewpoint_temperature_2m_p50',
        description: |||
          Median of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'dewpoint_temperature_2m_p75',
        description: |||
          75th percentile of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'dewpoint_temperature_2m_p90',
        description: |||
          90th percentile of 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'experimental_tp_1hr_mean',
        description: |||
          Mean of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'experimental_tp_1hr_p10',
        description: |||
          10th percentile of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'experimental_tp_1hr_p25',
        description: |||
          25th percentile of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'experimental_tp_1hr_p50',
        description: |||
          Median of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'experimental_tp_1hr_p75',
        description: |||
          75th percentile of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'experimental_tp_1hr_p90',
        description: |||
          90th percentile of experimental total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'high_cloud_cover_mean',
        description: |||
          Mean of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'high_cloud_cover_p10',
        description: |||
          10th percentile of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'high_cloud_cover_p25',
        description: |||
          25th percentile of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'high_cloud_cover_p50',
        description: |||
          Median of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'high_cloud_cover_p75',
        description: |||
          75th percentile of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'high_cloud_cover_p90',
        description: |||
          90th percentile of high cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'imerg_tp_1hr_mean',
        description: |||
          Mean of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'imerg_tp_1hr_p10',
        description: |||
          10th percentile of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'imerg_tp_1hr_p25',
        description: |||
          25th percentile of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'imerg_tp_1hr_p50',
        description: |||
          Median of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'imerg_tp_1hr_p75',
        description: |||
          75th percentile of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'imerg_tp_1hr_p90',
        description: |||
          90th percentile of IMERG total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'low_cloud_cover_mean',
        description: |||
          Mean of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'low_cloud_cover_p10',
        description: |||
          10th percentile of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'low_cloud_cover_p25',
        description: |||
          25th percentile of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'low_cloud_cover_p50',
        description: |||
          Median of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'low_cloud_cover_p75',
        description: |||
          75th percentile of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'low_cloud_cover_p90',
        description: |||
          90th percentile of low cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'mean_sea_level_pressure_mean',
        description: |||
          Mean of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'mean_sea_level_pressure_p10',
        description: |||
          10th percentile of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'mean_sea_level_pressure_p25',
        description: |||
          25th percentile of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'mean_sea_level_pressure_p50',
        description: |||
          Median of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'mean_sea_level_pressure_p75',
        description: |||
          75th percentile of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'mean_sea_level_pressure_p90',
        description: |||
          90th percentile of Mean sea level pressure
        |||,
        'gee:units': units.pascal
      },
      {
        name: 'medium_cloud_cover_mean',
        description: |||
          Mean of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'medium_cloud_cover_p10',
        description: |||
          10th percentile of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'medium_cloud_cover_p25',
        description: |||
          25th percentile of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'medium_cloud_cover_p50',
        description: |||
          Median of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'medium_cloud_cover_p75',
        description: |||
          75th percentile of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'medium_cloud_cover_p90',
        description: |||
          90th percentile of medium cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'sea_surface_temperature_mean',
        description: |||
          Mean of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'sea_surface_temperature_p10',
        description: |||
          10th percentile of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'sea_surface_temperature_p25',
        description: |||
          25th percentile of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'sea_surface_temperature_p50',
        description: |||
          Median of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'sea_surface_temperature_p75',
        description: |||
          75th percentile of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'sea_surface_temperature_p90',
        description: |||
          90th percentile of Sea surface temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_mean',
        description: |||
          Mean of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_p10',
        description: |||
          10th percentile of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_p25',
        description: |||
          25th percentile of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_p50',
        description: |||
          Median of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_p75',
        description: |||
          75th percentile of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'surface_solar_radiation_downwards_1hr_p90',
        description: |||
          90th percentile of surface solar radiation downwards (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'temperature_2m_mean',
        description: |||
          Mean of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'temperature_2m_p10',
        description: |||
          10th percentile of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'temperature_2m_p25',
        description: |||
          25th percentile of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'temperature_2m_p50',
        description: |||
          Median of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'temperature_2m_p75',
        description: |||
          75th percentile of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'temperature_2m_p90',
        description: |||
          90th percentile of 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'total_cloud_cover_mean',
        description: |||
          Mean of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_cloud_cover_p10',
        description: |||
          10th percentile of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_cloud_cover_p25',
        description: |||
          25th percentile of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_cloud_cover_p50',
        description: |||
          Median of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_cloud_cover_p75',
        description: |||
          75th percentile of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_cloud_cover_p90',
        description: |||
          90th percentile of total cloud cover
        |||,
        'gee:units': units.unspecified_fraction
      },
      {
        name: 'total_precipitation_1hr_mean',
        description: |||
          Mean of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_precipitation_1hr_p10',
        description: |||
          10th percentile of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_precipitation_1hr_p25',
        description: |||
          25th percentile of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_precipitation_1hr_p50',
        description: |||
          Median of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_precipitation_1hr_p75',
        description: |||
          75th percentile of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_precipitation_1hr_p90',
        description: |||
          90th percentile of total precipitation (1hr)
        |||,
        'gee:units': units.meter
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_mean',
        description: |||
          Mean of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_p10',
        description: |||
          10th percentile of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_p25',
        description: |||
          25th percentile of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_p50',
        description: |||
          Median of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_p75',
        description: |||
          75th percentile of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'total_sky_direct_solar_radiation_at_surface_1hr_p90',
        description: |||
          90th percentile of total sky direct solar radiation at surface (1hr)
        |||,
        'gee:units': units.joules_per_meter2
      },
      {
        name: 'u_component_of_wind_100m_mean',
        description: |||
          Mean of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_100m_p10',
        description: |||
          10th percentile of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_100m_p25',
        description: |||
          25th percentile of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_100m_p50',
        description: |||
          Median of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_100m_p75',
        description: |||
          75th percentile of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_100m_p90',
        description: |||
          90th percentile of 100 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_mean',
        description: |||
          Mean of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_p10',
        description: |||
          10th percentile of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_p25',
        description: |||
          25th percentile of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_p50',
        description: |||
          Median of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_p75',
        description: |||
          75th percentile of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'u_component_of_wind_10m_p90',
        description: |||
          90th percentile of 10 metre U wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_mean',
        description: |||
          Mean of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_p10',
        description: |||
          10th percentile of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_p25',
        description: |||
          25th percentile of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_p50',
        description: |||
          Median of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_p75',
        description: |||
          75th percentile of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_100m_p90',
        description: |||
          90th percentile of 100 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_mean',
        description: |||
          Mean of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_p10',
        description: |||
          10th percentile of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_p25',
        description: |||
          25th percentile of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_p50',
        description: |||
          Median of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_p75',
        description: |||
          75th percentile of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'v_component_of_wind_10m_p90',
        description: |||
          90th percentile of 10 metre V wind component
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_mean',
        description: |||
          Mean of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_p10',
        description: |||
          10th percentile of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_p25',
        description: |||
          25th percentile of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_p50',
        description: |||
          Median of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_p75',
        description: |||
          75th percentile of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_100m_p90',
        description: |||
          90th percentile of 100 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_mean',
        description: |||
          Mean of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_p10',
        description: |||
          10th percentile of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_p25',
        description: |||
          25th percentile of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_p50',
        description: |||
          Median of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_p75',
        description: |||
          75th percentile of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      },
      {
        name: 'wind_speed_10m_p90',
        description: |||
          90th percentile of 10 metre wind speed
        |||,
        'gee:units': units.velocity_si
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Temperature 2m Mean',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              220
            ],
            max: [
              350,
            ],
            palette: ['darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred'],
            bands: [
              'temperature_2m_mean',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    This placeholder text will be replaced with final content later on.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': |||
    This placeholder text will be replaced with final content later on.
  |||,
}
