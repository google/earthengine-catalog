local id = 'COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/BIO';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci
  ],
  id: id,
  title: 'Copernicus Global Ocean Bio-Geo-Chemical Forecast - BIO',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Operational Mercator Ocean biogeochemical global ocean analysis and
    forecast system at 1/4 degree is providing 10 days of 3D global ocean
    forecasts updated weekly. The time series is aggregated in time, in order
    to reach a two full year's time series sliding window. This product
    includes daily and monthly mean files of biogeochemical parameters
    (chlorophyll, nitrate, phosphate, silicate, dissolved oxygen, dissolved
    iron, primary production, phytoplankton, zooplankton, PH, and surface
    partial pressure of carbon dioxide) over the global ocean. The global
    ocean output files are displayed with a 1/4 degree horizontal resolution
    with regular longitude/latitude equirectangular projection. 50 vertical
    levels are ranging from 0 to 5700 meters.

    This dataset mainly consists of total primary production of phytos,
    and dissolved oxygen.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['oceans'],
  keywords: [
    'copernicus',
    'daily',
    'forecast',
    'marine',
    'ocean',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://marine.copernicus.eu/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      27750.0, // Approximately 0.25 degrees at the equator
    ],
    'eo:bands': [
      {
        name: 'nppv_depth%d' % depth_index,
        description: 'Total Primary Production of Phyto (depth %d)' % depth_index,
        'gee:units': units.mg_per_cubic_meter_per_day,
      }
      for depth_index in std.range(1, 50)
    ] + [
      {
        name: 'o2_depth%d' % depth_index,
        description: 'Dissolved Oxygen (depth %d)' % depth_index,
        'gee:units': units.mmol_per_cubic_meter,
      }
      for depth_index in std.range(1, 50)
    ],
    'gee:visualizations': [
      {
        display_name: 'Global BGC BIO Forecast',
        lookat: {
          lat: 73.63,
          lon: -140.5,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              50.0,
            ],
            palette: [
              'black',
              'blue',
              'cyan',
              'green',
              'yellow',
              'red',
              'white'
            ],
            bands: [
              'nppv_depth1',
            ],
          },
        },
      },
    ],
  } + {
    ['nppv_depth%d' % depth_index]: {
      minimum: 0,
      maximum: 2729.2,
      'gee:estimated_range': true,
    }
    for depth_index in std.range(1, 50)
  } + {
    ['o2_depth%d' % depth_index]: {
      minimum: 0.1,
      maximum: 516.16,
      'gee:estimated_range': true,
    }
    for depth_index in std.range(1, 50)
  },
  'sci:citation': |||
    E.U. Copernicus Marine Service Information.
    [https://doi.org/10.48670/moi-00015](https://doi.org/10.48670/moi-00015)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The data is provided free of charge by the Copernicus Marine Service.
    Users must acknowledge the Copernicus Marine Service as the data source
    when using the data. More details on the terms of use can be found on
    the [Copernicus Marine Service website](https://marine.copernicus.eu/user-corner/service-commitments-and-licence).
  |||,
}
