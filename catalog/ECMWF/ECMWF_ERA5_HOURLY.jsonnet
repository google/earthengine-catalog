local id = 'ECMWF/ERA5/HOURLY';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local era5 = import 'templates/ECMWF_ERA5.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

// ERA5 ocean-wave model (WAM) bands are on a 0.5-degree grid (55660 m), while
// atmospheric and land-surface (IFS) bands are on a 0.25-degree grid (27830 m).
local ocean_wave_bands = [
  'air_density_over_the_oceans',
  'benjamin_feir_index',
  'coefficient_of_drag_with_waves',
  'free_convective_velocity_over_the_oceans',
  'maximum_individual_wave_height',
  'mean_direction_of_total_swell',
  'mean_direction_of_wind_waves',
  'mean_period_of_total_swell',
  'mean_period_of_wind_waves',
  'mean_square_slope_of_waves',
  'mean_wave_direction',
  'mean_wave_direction_of_first_swell_partition',
  'mean_wave_direction_of_second_swell_partition',
  'mean_wave_direction_of_third_swell_partition',
  'mean_wave_period',
  'mean_wave_period_based_on_first_moment',
  'mean_wave_period_based_on_first_moment_for_swell',
  'mean_wave_period_based_on_first_moment_for_wind_waves',
  'mean_wave_period_based_on_second_moment_for_swell',
  'mean_wave_period_based_on_second_moment_for_wind_waves',
  'mean_wave_period_of_first_swell_partition',
  'mean_wave_period_of_second_swell_partition',
  'mean_wave_period_of_third_swell_partition',
  'mean_zero_crossing_wave_period',
  'model_bathymetry',
  'normalized_energy_flux_into_ocean',
  'normalized_energy_flux_into_waves',
  'normalized_stress_into_ocean',
  'ocean_surface_stress_equivalent_10m_neutral_wind_direction',
  'ocean_surface_stress_equivalent_10m_neutral_wind_speed',
  'peak_wave_period',
  'period_corresponding_to_maximum_individual_wave_height',
  'significant_height_of_combined_wind_waves_and_swell',
  'significant_height_of_total_swell',
  'significant_height_of_wind_waves',
  'significant_wave_height_of_first_swell_partition',
  'significant_wave_height_of_second_swell_partition',
  'significant_wave_height_of_third_swell_partition',
  'u_component_stokes_drift',
  'v_component_stokes_drift',
  'wave_spectral_directional_width',
  'wave_spectral_directional_width_for_swell',
  'wave_spectral_directional_width_for_wind_waves',
  'wave_spectral_kurtosis',
  'wave_spectral_peakedness',
  'wave_spectral_skewness',
];

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'ERA5 Hourly - ECMWF Climate Reanalysis',
  'gee:type': ee_const.gee_type.image_collection,
  description: era5.description,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['weather-and-climate'],
  keywords: era5.keywords,
  providers: [
    ee.producer_provider(
      'Copernicus Climate Change Service (C3S)',
      'https://cds.climate.copernicus.eu/datasets/reanalysis-era5-single-levels?tab=overview'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1940-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'hour',
        description: 'Hour of the day',
        type: ee_const.var_type.int,
      },
    ],
    'eo:bands': [
      {
        name: band.name,
        description: band.description,
        gsd: if std.member(ocean_wave_bands, band.name) then 55660.0 else 27830.0,
        [if std.objectHas(band, 'units') then 'gee:units']: band.units,
      }
      for band in era5.bands
    ],
    'gee:visualizations': era5.visualizations,
  },
  'sci:citation': era5.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
  },
  'gee:terms_of_use': era5.terms_of_use,
}
