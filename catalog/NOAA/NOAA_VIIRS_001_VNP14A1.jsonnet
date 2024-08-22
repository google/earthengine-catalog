local id = 'NOAA/VIIRS/001/VNP14A1';
local subdir = 'NOAA';
local successor_id = 'NASA/VIIRS/002/VNP14A1';
local latest_id = successor_id;
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VNP14A1.001: Thermal Anomalies/Fire Daily L3 Global 1km SIN Grid' +
  ' [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The daily Suomi National Polar-Orbiting Partnership NASA Visible Infrared
    Imaging Radiometer Suite (VIIRS) Thermal Anomalies/Fire (VNP14A1) Version 1
    data product provides daily information about active fires and other thermal
    anomalies. The VNP14A1 data product is a global, 1km gridded composite of
    fire pixels detected from VIIRS 750m bands over a daily (24-hour) period.
    The VNP14 data products are designed after the Moderate Resolution Imaging
    Spectroradiometer (MODIS) Thermal Anomalies/Fire product suite.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/427/VNP14_User_Guide_V1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/427/VNP14_User_Guide_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp14a1v001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP14A1.001',
    },
    ee.link.latest(
      latest_id,
      ee_const.catalog_base + 'NASA/' + latest_basename + '.json'),
    ee.link.successor(
      successor_id,
      ee_const.catalog_base + 'NASA/' + successor_basename + '.json'),
  ],
  keywords: [
    'fire',
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP14A1.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1523387372-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: {
    gsd: [
      1000.0,
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'FireMask',
        description: |||
          Confidence of fire.
        |||,
        'gee:classes': [
          {
            description: 'Not processed (no data or poor quality data)',
            value: 0,
          },
          {
            value: 1,
            description: 'Not processed (bowtie deletion)',
          },
          {
            value: 2,
            description: 'Unused',
          },
          {
            value: 3,
            description: 'Water',
          },
          {
            value: 4,
            description: 'Cloud',
          },
          {
            value: 5,
            description: 'Land',
          },
          {
            value: 6,
            description: 'Unclassified',
          },
          {
            value: 7,
            description: 'Low confidence fire pixel',
          },
          {
            value: 8,
            description: 'Nominal confidence fire pixel',
          },
          {
            value: 9,
            description: 'High confidence fire pixel',
          },
        ],
      },
      {
        name: 'MaxFRP',
        description: 'Maximum Fire Radiative Power',
        'gee:units': units.megawatt,
      },
      {
        name: 'QA',
        description: 'Global Land Surface Phenology Quality Control',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'land/water state',
              bit_count: 2,
              values: [
                {
                  description: 'water',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'coast',
                },
                {
                  value: 2,
                  description: 'land',
                },
                {
                  value: 3,
                  description: 'unused',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'EDR ground trim zone',
              bit_count: 1,
              values: [
                {
                  description: 'false',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'true',
                },
              ],
              first_bit: 2,
            },
            {
              description: 'atmospheric correction performed',
              bit_count: 1,
              values: [
                {
                  description: 'no',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'yes',
                },
              ],
              first_bit: 3,
            },
            {
              description: 'day/night algorithm',
              bit_count: 1,
              values: [
                {
                  description: 'night',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'day',
                },
              ],
              first_bit: 4,
            },
            {
              description: 'potential fire pixel',
              bit_count: 1,
              values: [
                {
                  description: 'false',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'true',
                },
              ],
              first_bit: 5,
            },
            {
              description: 'Unused0',
              bit_count: 1,
              values: [
                {
                  description: 'Unused value',
                  value: 0,
                },
              ],
              first_bit: 6,
            },
            {
              description: 'background window size parameter',
              bit_count: 4,
              first_bit: 7,
            },
            {
              description: 'individual detection test flags',
              bit_count: 6,
              values: [
                {
                  description: 'fail',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'pass',
                },
              ],
              first_bit: 11,
            },
            {
              description: 'Unused1',
              bit_count: 3,
              values: [
                {
                  description: 'Unused value',
                  value: 0,
                },
              ],
              first_bit: 17,
            },
            {
              description: 'adjacent cloud pixel',
              bit_count: 1,
              values: [
                {
                  description: 'no',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'yes',
                },
              ],
              first_bit: 20,
            },
            {
              description: 'adjacent water pixel',
              bit_count: 1,
              values: [
                {
                  description: 'no',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'yes',
                },
              ],
              first_bit: 21,
            },
            {
              description: 'Sun glint level',
              bit_count: 2,
              values: [
                {
                  description: 'Sun glint level - 1',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Sun glint level - 2',
                },
                {
                  value: 2,
                  description: 'Sun glint level - 3',
                },
                {
                  value: 3,
                  description: 'Sun glint level - 4',
                },
              ],
              first_bit: 22,
            },
            {
              description: 'individual rejection test flags',
              bit_count: 5,
              values: [
                {
                  description: 'false',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'true',
                },
              ],
              first_bit: 24,
            },
            {
              description: 'Unused2',
              bit_count: 3,
              values: [
                {
                  description: 'Unused value',
                  value: 0,
                },
              ],
              first_bit: 29,
            },
          ],
          total_bit_count: 32,
        },
      },
      {
        name: 'sample',
        description: 'Sample number within a swath',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Maximum Fire Radiative Power',
        lookat: {
          lat: -1.94,
          lon: 10.35,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1,
            ],
            max: [
              10000,
            ],
            palette: [
              '000000',
              '004400',
              '008800',
              '00bb00',
              '00ff00',
            ],
            bands: [
              'MaxFRP',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP14A1.001',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
