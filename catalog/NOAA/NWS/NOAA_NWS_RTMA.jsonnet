local id = 'NOAA/NWS/RTMA';
local subdir = 'NOAA/NWS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  ],
  id: id,
  title: 'RTMA: Real-Time Mesoscale Analysis',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Real-Time Mesoscale Analysis (RTMA) is a high-spatial and temporal
    resolution analysis for near-surface weather conditions.  This dataset
    includes hourly analyses at 2.5 km for CONUS.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'climate',
    'cloud',
    'geophysical',
    'humidity',
    'noaa',
    'nws',
    'precipitation',
    'pressure',
    'rtma',
    'surface',
    'temperature',
    'visibility',
    'weather',
    'wind',
  ],
  providers: [
    ee.producer_provider('NOAA/NWS', 'https://www.nco.ncep.noaa.gov/pmb/products/rtma/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-130.17, 20.15, -60.81, 52.91,
                    '2011-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      2500.0,
    ],
    'eo:bands': [
      {
        name: 'HGT',
        description: 'Model terrain elevation',
        'gee:units': units.meters,
      },
      {
        name: 'PRES',
        description: 'Pressure',
        'gee:units': 'Pa',
      },
      {
        name: 'TMP',
        description: 'Temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'DPT',
        description: 'Dew point temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'UGRD',
        description: 'U-component of wind',
        'gee:units': 'm/s',
      },
      {
        name: 'VGRD',
        description: 'V-component of wind',
        'gee:units': 'm/s',
      },
      {
        name: 'SPFH',
        description: 'Specific humidity',
        'gee:units': units.mass_fraction,
      },
      {
        name: 'WDIR',
        description: 'Wind direction (from which blowing)',
        'gee:units': 'deg true',
      },
      {
        name: 'WIND',
        description: 'Wind speed',
        'gee:units': 'm/s',
      },
      {
        name: 'GUST',
        description: 'Wind speed (gust)',
        'gee:units': 'm/s',
      },
      {
        name: 'VIS',
        description: 'Visibility',
        'gee:units': units.meters,
      },
      {
        name: 'TCDC',
        description: 'Total cloud cover',
        'gee:units': units.percent,
      },
      {
        name: 'ACPC01',
        description: 'Total precipitation',
        'gee:units': 'kg/(m^2)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Wind Speed',
        lookat: {
          lat: 39.91,
          lon: -95.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              12.0,
            ],
            palette: [
              '001137',
              '01abab',
              'e7eb05',
              '620500',
            ],
            bands: [
              'WIND',
            ],
          },
        },
      },
    ],
    HGT: {
      minimum: -81.0,
      maximum: 4226.0,
      'gee:estimated_range': true,
    },
    PRES: {
      minimum: 60848.0,
      maximum: 105183.0,
      'gee:estimated_range': true,
    },
    TMP: {
      minimum: -43.2,
      maximum: 43.73,
      'gee:estimated_range': true,
    },
    DPT: {
      minimum: -81.41,
      maximum: 30.92,
      'gee:estimated_range': true,
    },
    UGRD: {
      minimum: -32.93,
      maximum: 34.04,
      'gee:estimated_range': true,
    },
    VGRD: {
      minimum: -28.44,
      maximum: 39.21,
      'gee:estimated_range': true,
    },
    SPFH: {
      minimum: 0.0,
      maximum: 0.02,
      'gee:estimated_range': true,
    },
    WDIR: {
      minimum: 0.0,
      maximum: 360.0,
      'gee:estimated_range': true,
    },
    WIND: {
      minimum: 0.0,
      maximum: 42.46,
      'gee:estimated_range': true,
    },
    GUST: {
      minimum: 0.0,
      maximum: 58.02,
      'gee:estimated_range': true,
    },
    VIS: {
      minimum: 0.0,
      maximum: 20000.0,
      'gee:estimated_range': true,
    },
    TCDC: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    ACPC01: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 1,
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
