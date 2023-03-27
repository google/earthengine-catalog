local id = 'UCSB-CHG/CHIRPS/DAILY';
local subdir = 'UCSB-CHG';

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
  title: 'CHIRPS Daily: Climate Hazards Group InfraRed Precipitation With Station Data (Version 2.0 Final)',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Climate Hazards Group InfraRed Precipitation with Station data (CHIRPS)
    is a 30+ year quasi-global rainfall dataset. CHIRPS incorporates
    0.05° resolution satellite imagery with in-situ station data
    to create gridded rainfall time series for trend analysis and seasonal
    drought monitoring.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'chg',
    'climate',
    'geophysical',
    'precipitation',
    'ucsb',
    'weather',
  ],
  providers: [
    ee.producer_provider('UCSB/CHG', 'https://chc.ucsb.edu/data/chirps'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -50.0, 180.0, 50.0, '1981-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      5566.0,
    ],
    'eo:bands': [
      {
        name: 'precipitation',
        description: 'Precipitation',
        'gee:units': units.millimeter_per_day,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              17.0,
            ],
            palette: [
              '001137',
              '0aab1e',
              'e7eb05',
              'ff4a2d',
              'e90000',
            ],
            bands: [
              'precipitation',
            ],
          },
        },
      },
    ],
    precipitation: {
      minimum: 0.0,
      maximum: 1444.34,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Funk, Chris, Pete Peterson, Martin Landsfeld, Diego Pedreros, James
    Verdin, Shraddhanand Shukla, Gregory Husak, James Rowland, Laura Harrison,
    Andrew Hoell & Joel Michaelsen. "The climate hazards infrared precipitation
    with stations-a new environmental record for monitoring extremes".
    Scientific Data 2, 150066. [doi:10.1038/sdata.2015.66](https://doi.org/10.1038/sdata.2015.66)
    2015.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This datasets are in the public domain. To the extent possible under law,
    [Pete Peterson](https://chc.ucsb.edu/people/pete-peterson)
    has waived all copyright and related or neighboring rights to
    Climate Hazards Group Infrared Precipitation with Stations (CHIRPS).
  |||,
}
