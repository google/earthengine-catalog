local id = 'NOAA/CDR/SST_WHOI/V2';
local subdir = 'NOAA';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NOAA CDR WHOI: Sea Surface Temperature, Version 2',
  version: 'V2',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Sea Surface Temperature - WHOI dataset is part of the NOAA Ocean Surface
    Bundle (OSB) and provides a high quality Climate Data Record (CDR) of sea
    surface temperature over ice-free oceans.

    The SST values are found through modeling the diurnal variability in
    combination with AVHRR observations of sea surface temperature.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5FB510W',
    },
  ],
  keywords: [
    'atmospheric',
    'cdr',
    'hourly',
    'noaa',
    'ocean',
    'oisst',
    'osb',
    'sst',
    'whoi',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncdc.noaa.gov/cdr/oceanic/sea-surface-temperature-whoi'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1988-01-01T00:00:00Z', '2021-08-31T00:00:00Z'),
  summaries: {
    gsd: [
      27830.0,
    ],
    'eo:bands': [
      {
        name: 'sea_surface_temperature',
        description: 'Optimum Interpolation Sea Surface Temperature (OISST), with a diurnal warming correction',
        'gee:units': units.celsius,
      },
      {
        name: 'fill_missing_qc',
        description: 'Quality control flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Quality control flags',
              bit_count: 3,
              values: [
                {
                  description: 'Pixel values from neural network',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Unused flag',
                },
                {
                  value: 2,
                  description: 'Snow/ice',
                },
                {
                  value: 3,
                  description: 'Over land',
                },
                {
                  value: 4,
                  description: 'Over lake',
                },
                {
                  value: 5,
                  description: 'SST missing, SST unresolved',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 3,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sea Surface Temperature',
        lookat: {
          lat: -21.09,
          lon: -4.92,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              30.0,
            ],
            palette: [
              '040274',
              '040281',
              '0502a3',
              '0502b8',
              '0502ce',
              '0502e6',
              '0602ff',
              '235cb1',
              '307ef3',
              '269db1',
              '30c8e2',
              '32d3ef',
              '3be285',
              '3ff38f',
              '86e26f',
              '3ae237',
              'b5e22e',
              'd6e21f',
              'fff705',
              'ffd611',
              'ffb613',
              'ff8b13',
              'ff6e08',
              'ff500d',
              'ff0000',
              'de0101',
              'c21301',
              'a71001',
              '911003',
            ],
            bands: [
              'sea_surface_temperature',
            ],
          },
        },
      },
    ],
    sea_surface_temperature: {
      minimum: -1.79,
      maximum: 35.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5FB510W',
  'sci:citation': |||
    Clayson, Carol Anne, Brown, Jeremiah, and NOAA CDR Program (2016). NOAA
    Climate Data Record Ocean Surface Bundle (OSB) Climate Data Record (CDR) of
    Sea Surface Temperature - WHOI, Version 2. [indicate subset used]. NOAA
    National Climatic Data Center. [doi:10.7289/V5FB510W](https://doi.org/10.7289/V5FB510W).
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'hour',
    interval: 3,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
