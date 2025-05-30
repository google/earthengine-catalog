local id = 'UCSB/CHC/CMIP6/v1';
local subdir = 'UCSB';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'The Climate Hazards Center (CHC) Coupled Model Intercomparison Project Phase 6 (CHC-CMIP6)',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    CHC-CMIP6 was explicitly developed to support the analysis of
    climate-related hazards over the recent past and in the near-future.

    This climate projection dataset contains global, daily gridded data for the
    observational (1983-2016) and projection (2030 and 2050) periods to be used
    in the identification and monitoring of hydroclimatic extremes. The dataset
    contains global daily high resolution (0.05&#176;) grids of the Climate
    Hazards InfraRed Temperature with Stations (CHIRTS-daily) temperature
    product, the Climate Hazards InfraRed Precipitation with Stations (CHIRPS)
    precipitation product, and ERA5-derived relative humidity, from which Vapor
    Pressure Deficits (VPD) and maximum Wet Bulb Globe Temperatures (WBGTmax)
    were derived.

    Large CMIP6 ensembles from the Shared Socioeconomic Pathway (SSP) 245 and
    SSP 585 scenarios were used to develop high resolution (0.05&#176;) daily
    2030 and 2050 delta fields.

    For more information, see
    [The Climate Hazards Center (CHC) Coupled Model Intercomparison Project
    Phase 6 (CHC-CMIP6)](https://chc.ucsb.edu/data/chc-cmip6).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['precipitation'],
  keywords: [
    'climate',
    'geophysical',
    'precipitation',
    'ucsb',
    'weather',
  ],
  providers: [
    ee.producer_provider('UCSB', 'https://chc.ucsb.edu/data/chc-cmip6'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -50.0, 180.0, 50.0, '1983-01-01T00:00:00Z', '2016-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'projection_year',
        description: 'Projection Year',
        type: ee_const.var_type.int,
      },
      {
        name: 'scenario',
        description: 'Shared Socioeconomic Pathway (SSP) scenarios',
        type: ee_const.var_type.string,
      }
    ],
    gsd: [
      5566.0,
    ],
    'eo:bands': [
      {
        "name": "CHIRPS",
        "description": "Daily total precipitation.",
        "gee:units": units.millimeter_per_day
      },
      {
        "name": "himax",
        "description": "Daily maximum Heat Index.",
        "gee:units": units.celsius
      },
      {
        "name": "RH",
        "description": "Relative Humidity.",
        "gee:units": units.percent
      },
      {
        "name": "RHx",
        "description": "Relative humidity at the hour of maximum temperature",
        "gee:units": units.percent
      },
      {
        "name": "RHn",
        "description": "Relative humidity at the hour of minimum temperature.",
        "gee:units": units.percent
      },
      {
        "name": "wbgtmax",
        "description": "Daily maximum wet bulb globe temperature.",
        "gee:units": units.celsius
      },
      {
        "name": "vpd",
        "description": "Daily vapor pressure deficit.",
        "gee:units": units.kilopascal
      },
      {
        "name": "svp",
        "description": "Daily average saturation vapor pressure.",
        "gee:units": units.kilopascal
      },
      {
        "name": "Tmax",
        "description": "Daily maximum near-surface air temperature.",
        "gee:units": units.celsius
      },
      {
        "name": "Tmin",
        "description": "Daily minimum near-surface air temperature.",
        "gee:units": units.celsius
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'CHC CMIP6',
        lookat: {
          lat: 10.14,
          lon: 93.17,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'd7191c',
              'fdae61',
              'ffffbf',
              'abd9e9',
              '2c7bb6'
            ],
            bands: [
              'CHIRPS',
            ],
          },
        },
      },
    ],
    CHIRPS: {
      minimum: 0.0,
      maximum: 751.05,
      'gee:estimated_range': false,
    },
    himax: {
      minimum: -49.76,
      maximum: 78.56,
      'gee:estimated_range': false,
    },
    RH: {
      minimum: -1.33,
      maximum: 100,
      'gee:estimated_range': false,
    },
    RHx: {
      minimum: -3.11,
      maximum: 100,
      'gee:estimated_range': false,
    },
    RHn: {
      minimum: -2.603,
      maximum: 100,
      'gee:estimated_range': false,
    },
    wbgtmax: {
      minimum: -100.54,
      maximum: 33.76,
      'gee:estimated_range': false,
    },
    vpd: {
      minimum: 0,
      maximum: 67.98,
      'gee:estimated_range': false,
    },
    svp: {
      minimum: 0.011,
      maximum: 71.41,
      'gee:estimated_range': false,
    },
    Tmax: {
      minimum: -43.04,
      maximum: 90.52,
      'gee:estimated_range': false,
    },
    Tmin: {
      minimum: -46.72,
      maximum: 89.82,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Williams, E., Funk, C., Peterson, P., & Tuholske, C. (2024). High resolution
    climate change observations and projections for the evaluation of
    heat-related extremes. Scientific Data, 11(1), 261.
    [https://www.nature.com/articles/s41597-024-03074-w](https://www.nature.com/articles/s41597-024-03074-w)
    2015.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The dataset is under a Creative Commons Attribution 4.0 International
    (CC BY 4.0) license. For more information, see
    [The Climate Hazards Center (CHC) Coupled Model Intercomparison Project
    Phase 6 (CHC-CMIP6)](https://chc.ucsb.edu/data/chc-cmip6).
  |||,
}
