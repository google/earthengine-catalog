local id = 'UCSB-CHC/CHIRPS/V3/DAILY_SAT';
local subdir = 'UCSB-CHC';

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
  title: 'CHIRPS Precipitation Daily Near-Real-Time: Climate Hazards Center InfraRed Precipitation With Station Data (Version 3.0, IMERG-based)',
  version: '3.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Climate Hazards Center Infrared Precipitation with Stations (CHIRPS v3)
    is a 40+ year, high-resolution quasi-global rainfall dataset. It spans
    60&deg;N to 60&deg;S and covers all longitudes, providing data from 1981 to
    near-present. CHIRPS v3 combines satellite-based thermal infrared rainfall
    estimates with in-situ station observations to produce a 0.05&deg; gridded
    rainfall time series over land. This is version 3.0 of the dataset, for more
    information see [the CHC page](https://www.chc.ucsb.edu/data/chirps3).

    CHIRPS is fundamentally a pentad and monthly product from which other
    time steps are derived. This daily dataset ('sat') uses daily precipitation
    from the NASA IMERG Late V07 data product (IMERG) to partition pentadal
    CHIRPS-v3 precipitation totals into daily amounts.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['precipitation'],
  keywords: [
    'chc',
    'climate',
    'geophysical',
    'precipitation',
    'ucsb',
    'weather',
  ],
  providers: [
    ee.producer_provider('UCSB/CHC', 'https://www.chc.ucsb.edu/data/chirps3'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 60.0, '1981-01-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
      {
        name: 'month',
        description: 'Month',
        type: ee_const.var_type.double,
      },
      {
        name: 'day',
        description: 'Day',
        type: ee_const.var_type.double,
      },
    ],
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
              '2c7fb8',
              '253494',
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
    Climate Hazards Center Infrared Precipitation with Stations version 3.
    CHIRPS3 Data Repository [doi:10.15780/G2JQ0P](https://doi.org/10.15780/G2JQ0P) (2025).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain. To the extent possible under law,
    [Pete Peterson](https://chc.ucsb.edu/people/pete-peterson)
    has waived all copyright and related or neighboring rights to
    Climate Hazards Center Infrared Precipitation with Stations (CHIRPS).
  |||,
}
