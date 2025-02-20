local id = 'NOAA/CPC/Temperature';
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
  ],
  id: id,
  title: 'CPC Global Unified Temperature',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides a gridded analysis of daily surface air temperature
    over global land areas, including daily maximum (Tmax), minimum (Tmin)
    temperatures. Spanning from 1979 to the present, the data is presented on
    0.5-degree latitude/longitude grids, aligning with the resolution of CPC's
    gauge-based global daily precipitation analysis. The construction of this
    dataset considers orographic effects. Its primary purpose is to support
    climate monitoring and forecast verification activities. Input data
    originates from the CPC archive of GTS (Global Telecommunication System)
    daily reports, incorporating Tmax and Tmin data from approximately 6,000 to
    7,000 global stations.

    Refer [this](https://ftp.cpc.ncep.noaa.gov/precip/PEOPLE/wd52ws/global_temp/CPC-GLOBAL-T.pdf)
    for technical documentation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: [
    'daily',
    'noaa',
    'precipitation',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA Physical Sciences Laboratory', 'https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1979-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      55500.0,
    ],
    'eo:bands': [
      {
        name: 'tmax',
        description: 'daily maximum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'tmin',
        description: 'daily minimum temperature',
        'gee:units': units.celsius,
      },
      {
        name: 'nmax',
        description: 'number of reports for maximum temperature',
      },
      {
        name: 'nmin',
        description: 'number of reports for minimum temperature',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NOAA CPC Temperature',
        lookat: {
          lon: -104.8,
          lat: 49.1,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              -40,
            ],
            max: [
              50.0,
            ],
            palette: [
              'ADD8E6',
              '008000',
              'FFFF00',
              'FFA500',
              'FF0000',
              '800080',
            ],
            bands: [
              'tmax',
            ],
          },
        },
      },
    ],
    tmax: {
      minimum: -89.84,
      maximum: 66.03,
      'gee:estimated_range': true,
    },
    tmin: {
      minimum: -97.92,
      maximum: 54.26,
      'gee:estimated_range': true,
    },
    nmax: {
      minimum: 0,
      maximum: 7,
      'gee:estimated_range': true,
    },
    nmin: {
      minimum: 0,
      maximum: 7,
      'gee:estimated_range': true,
    },
  },
  'gee:terms_of_use': |||
    The NOAA CPC datasets are available without restriction
    on use or distribution. NOAA PSL does request that the
    user give proper attribution and identify NOAA PSL, where applicable,
    as the source of the data.
  |||,
}
