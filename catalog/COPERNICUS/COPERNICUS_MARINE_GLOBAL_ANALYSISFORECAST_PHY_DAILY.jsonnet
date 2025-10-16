local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_PHY_DAILY';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local marine_common = import 'templates/COPERNICUS_MARINE_OC_GLO_BGC.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Global Ocean Physics Analysis and Forecast Daily',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Copernicus Marine Physics 2D Daily Mean Fields
    (cmems_mod_glo_phy_anfc_0.083deg_P1D-m) deliver global daily-averaged ocean
    surface and bottom variables at 8km resolution.

    The Operational Mercator global ocean analysis and forecast system is
    providing 10 days of 2D global ocean forecasts updated daily.
    The time series is aggregated in time in order to reach a two full year's
    time series sliding window. This product includes daily mean
    files of temperature, salinity, currents, sea level, mixed layer depth and
    ice parameters from the top to the bottom over the global ocean.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['oceans'],
  keywords: [
    'copernicus',
    'daily',
    'marine',
    'forecast',
  ],
  providers: [
    ee.producer_provider('Copernicus Marine Service', 'https://data.marine.copernicus.eu/product/GLOBAL_ANALYSISFORECAST_PHY_001_024/description'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-06-01T00:00:00Z', null),
  summaries: {
    gsd: [
      9276.62,
    ],
    'eo:bands': [
      {
        name: 'sialb',
        description: 'Mean albedo over sea ice',
        'gee:units': units.percent,
      },
      {
        name: 'siage',
        description: 'Mean sea ice age',
        'gee:units': units.year,
      },
      {
        name: 'siconc',
        description: 'Sea Ice Concentration',
        'gee:units': units.dimensionless,
      },
      {
        name: 'ist',
        description: 'Sea Ice Surface Temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'sivelo',
        description: 'Sea Ice Velocity',
        'gee:units': units.velocity_si,
      },
      {
        name: 'sithick',
        description: 'Sea Ice Thickness',
        'gee:units': units.meter,
      },
      {
        name: 'sisnthick',
        description: 'Sea Ice Surface Snow Thickness',
        'gee:units': units.meter,
      },
      {
        name: 'mlotst',
        description: 'Mixed Layer Depth',
        'gee:units': units.meter,
      },
      {
        name: 'pbo',
        description: 'Sea Water Pressure at Sea floor',
        'gee:units': units.pascal,
      },
      {
        name: 'sob',
        description: 'Sea Bottom Salinity',
        'gee:units': units.practical_salinity_unit,
      },
      {
        name: 'zos',
        description: 'Sea Surface Height',
        'gee:units': units.meter,
      },
      {
        name: 'tob',
        description: 'Sea Bottom Temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'usi',
        description: 'Sea Ice Eastward Velocity',
        'gee:units': units.velocity_si,
      },
      {
        name: 'vsi',
        description: 'Sea Ice Northward Velocity',
        'gee:units': units.velocity_si,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sea Surface Height',
        lookat: {
          lat: 52.2,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [-2.0],
            max: [1.5],
            palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
            bands: ['zos'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'lag_hours',
        description: |||
          For observations in the past, the number of hours between the
          observation and run times.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'forecast_hours',
        description: |||
          For observations in the future, the number of hours between the
          observation and run times.
        |||,
        type: 'DOUBLE',
      },
      {
        name: 'observation_time',
        description: 'The valid time of the observation, in milliseconds.',
        type: 'DOUBLE',
      },
      {
        name: 'observation_type',
        description: |||
          Observation type:

          *   **forecast**: Future model prediction
          *   **hindcast**: Past model reconstruction
          *   **nowcast**: Best estimate of the current state
        |||,
        type: 'STRING',
      },
      {
        name: 'run_time',
        description: 'The time the observation was produced, in milliseconds.',
        type: 'DOUBLE',
      },
    ],
  },
  'sci:citation': |||
    E.U. Copernicus Marine Service Information (2024). Global Ocean Physics Analysis and Forecast.
    [doi:10.48670/moi-00016](https://doi.org/10.48670/moi-00016)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': marine_common.term_of_use,
}
