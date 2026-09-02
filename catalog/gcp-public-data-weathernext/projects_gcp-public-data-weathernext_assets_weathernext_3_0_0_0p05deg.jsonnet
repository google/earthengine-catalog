local id = 'projects/gcp-public-data-weathernext/assets/weathernext_3_0_0_0p05deg';
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
  title: 'WeatherNext 3 (0.05&deg;)',
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
    gsd: [5566],
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
          The band names in the order, starting from B0 to B11.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'eo:bands': [
      {
        name: 'station_head_dewpoint_temperature_2m_mean',
        description: |||
          Mean of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_dewpoint_temperature_2m_p10',
        description: |||
          10th percentile of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_dewpoint_temperature_2m_p25',
        description: |||
          25th percentile of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_dewpoint_temperature_2m_p50',
        description: |||
          Median of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_dewpoint_temperature_2m_p75',
        description: |||
          75th percentile of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_dewpoint_temperature_2m_p90',
        description: |||
          90th percentile of station head 2 metre dewpoint temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_mean',
        description: |||
          Mean of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_p10',
        description: |||
          10th percentile of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_p25',
        description: |||
          25th percentile of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_p50',
        description: |||
          Median of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_p75',
        description: |||
          75th percentile of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      },
      {
        name: 'station_head_temperature_2m_p90',
        description: |||
          90th percentile of station head 2 metre temperature
        |||,
        'gee:units': units.kelvin
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'Station Head Temperature 2m Mean',
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
              'station_head_temperature_2m_mean',
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
