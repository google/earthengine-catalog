local id = 'NOAA/CDR/AVHRR/SR/V5';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/AVHRR_SR_versions.libsonnet';

local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NOAA CDR AVHRR: Surface Reflectance, Version 5',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA Climate Data Record (CDR) of AVHRR Surface Reflectance contains
    gridded daily surface reflectance and brightness temperatures derived from
    the Advanced Very High Resolution Radiometer (AVHRR) sensors onboard seven
    NOAA polar orbiting satellites. The data are gridded at a
    resolution of 0.05° and computed globally over land surfaces.

    Known issues with this dataset include:

    - TIMEOFDAY variable contains values that are too large by 1 day

    - Latitude values are not correctly associated with the center of
      the grid cell, error is < 0.002 degrees

    - Longitude values are not correctly associated with the center of
      the grid cell, error is < 0.02 degrees

    See [technical note from the data provider](https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/Surface_Reflectance/AVHRR/AlgorithmDescriptionAVHRR_01B-20a.pdf).

    Provider's note: the orbital drift of N-19 (the last NOAA satellite
    carrying the AVHRR sensor) began to severely degrade the retrieved
    product quality. Therefore, VIIRS is now the primary sensor being used for
    these products from 2014-present.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V53776Z4',
    },
  ] + version_config.version_links,
  keywords: [
    'avhrr',
    'cdr',
    'daily',
    'land',
    'noaa',
    'reflectance',
    'sr',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncdc.noaa.gov/cdr/terrestrial/avhrr-surface-reflectance'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1981-06-24T00:00:00Z', '2013-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'status',
        description: "'provisional' or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    gsd: [
      5566.0,
    ],
    platform: [
      'NOAA-07',
      'NOAA-09',
      'NOAA-11',
      'NOAA-14',
      'NOAA-16',
      'NOAA-17',
      'NOAA-18',
    ],
    instruments: [
      'AVHRR',
    ],
    'eo:bands': [
      {
        name: 'SREFL_CH1',
        description: 'Bidirectional surface reflectance',
        center_wavelength: 0.64,
        'gee:scale': 0.0001,
        'gee:wavelength': '640nm',
      },
      {
        name: 'SREFL_CH2',
        description: 'Bidirectional surface reflectance',
        center_wavelength: 0.86,
        'gee:scale': 0.0001,
        'gee:wavelength': '860nm',
      },
      {
        name: 'SREFL_CH3',
        description: 'Bidirectional surface reflectance',
        center_wavelength: 3.75,
        'gee:scale': 0.0001,
        'gee:wavelength': '3.75&micro;m',
      },
      {
        name: 'BT_CH3',
        description: 'Brightness temperature',
        'gee:units': units.kelvin,
        center_wavelength: 3.75,
        'gee:scale': 0.1,
        'gee:wavelength': '3.75&micro;m',
      },
      {
        name: 'BT_CH4',
        description: 'Brightness temperature',
        'gee:units': units.kelvin,
        center_wavelength: 11.0,
        'gee:scale': 0.1,
        'gee:wavelength': '11.0&micro;m',
      },
      {
        name: 'BT_CH5',
        description: 'Brightness temperature',
        'gee:units': units.kelvin,
        center_wavelength: 12.0,
        'gee:scale': 0.1,
        'gee:wavelength': '12.0&micro;m',
      },
      {
        name: 'TIMEOFDAY',
        description: 'Hours since start of day',
        'gee:units': units.hour,
        'gee:scale': 0.01,
      },
      {
        name: 'RELAZ',
        description: 'Relative sensor azimuth angle',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'SZEN',
        description: 'Solar zenith angle',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'VZEN',
        description: 'View zenith angle, scale 0.01',
        'gee:units': units.degree,
        'gee:scale': 0.01,
      },
      {
        name: 'QA',
        description: 'Quality control bit flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Unused',
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Pixel is cloudy',
              first_bit: 1,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Pixel contains cloud shadow',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Pixel is over water',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Pixel is over sunglint',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Pixel is over dense dark vegetation',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Pixel is at night (high solar zenith)',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channels 1-5 are valid',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channel 1 value is invalid',
              first_bit: 8,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channel 2 value is invalid',
              first_bit: 9,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channel 3 value is invalid',
              first_bit: 10,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channel 4 value is invalid',
              first_bit: 11,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Channel 5 value is invalid',
              first_bit: 12,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'RHO3 value is invalid',
              first_bit: 13,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'BRDF correction is invalid',
              first_bit: 14,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Polar flag, latitude over 60 degrees (land) or 50 degrees (ocean)',
              first_bit: 15,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
          ],
          total_bit_count: 16,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Surface Reflectance',
        lookat: {
          lat: 71.72,
          lon: 52.48,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1000.0,
            ],
            max: [
              9000.0,
            ],
            palette: [
              '003b02',
              '006a03',
              '008d05',
              '01be07',
              '01ff09',
              'ffffff',
            ],
            bands: [
              'SREFL_CH1',
            ],
          },
        },
      },
    ],
    SREFL_CH1: {
      minimum: 1.0,
      maximum: 10000.0,
      'gee:estimated_range': true,
    },
    SREFL_CH2: {
      minimum: 1.0,
      maximum: 10000.0,
      'gee:estimated_range': true,
    },
    SREFL_CH3: {
      minimum: -32768.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    BT_CH3: {
      minimum: -32519.0,
      maximum: 30136.0,
      'gee:estimated_range': true,
    },
    BT_CH4: {
      minimum: -32519.0,
      maximum: 31450.0,
      'gee:estimated_range': true,
    },
    BT_CH5: {
      minimum: -7623.0,
      maximum: 18788.0,
      'gee:estimated_range': true,
    },
    TIMEOFDAY: {
      minimum: 0.0,
      maximum: 2399.0,
      'gee:estimated_range': true,
    },
    RELAZ: {
      minimum: -32768.0,
      maximum: 32767.0,
      'gee:estimated_range': true,
    },
    SZEN: {
      minimum: 219.0,
      maximum: 8546.0,
      'gee:estimated_range': true,
    },
    VZEN: {
      minimum: 0.0,
      maximum: 6936.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V53776Z4',
  'sci:citation': |||
    Eric Vermote, Chris Justice, Ivan Csiszar, Jeff Eidenshink, Ranga Myneni,
    Frederic Baret, Ed Masuoka, Robert Wolfe, Martin Claverie and NOAA CDR
    Program (2014): NOAA Climate Data Record (CDR) of AVHRR Surface Reflectance,
    Version 4. [indicate subset used]. NOAA National Climatic Data Center.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
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
