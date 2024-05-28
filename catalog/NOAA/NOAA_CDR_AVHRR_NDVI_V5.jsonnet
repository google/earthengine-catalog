local id = 'NOAA/CDR/AVHRR/NDVI/V5';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/AVHRR_NDVI_versions.libsonnet';

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
  title: 'NOAA CDR AVHRR NDVI: Normalized Difference Vegetation Index, Version 5',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA Climate Data Record (CDR) of AVHRR Normalized Difference Vegetation
    Index (NDVI) contains gridded daily NDVI derived from the NOAA AVHRR Surface
    Reflectance product. It provides a measurement of surface vegetation
    coverage activity, gridded at a resolution of 0.05° and computed globally
    over land surfaces.

    Known issues with this dataset include:

    - TIMEOFDAY variable contains values that are too large by 1 day

    - Latitude values are not correctly associated with the center of
      the grid cell, error is < 0.002 degrees

    - Longitude values are not correctly associated with the center of
      the grid cell, error is < 0.02 degrees

    See [technical note from the data provider](https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/Normalized_Difference_Vegetation_Index/AVHRR/AlgorithmDescriptionAVHRR_01B-20b.pdf).

    Provider's note: the orbital drift of N-19 (the last NOAA satellite
    carrying the AVHRR sensor) began to severely degrade the retrieved
    product quality. Therefore, VIIRS is now the primary sensor being used for
    these products from 2014-present.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5PZ56R6',
    },
  ] + version_config.version_links,
  keywords: [
    'avhrr',
    'cdr',
    'daily',
    'land',
    'ndvi',
    'noaa',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/climate-data-records/normalized-difference-vegetation-index'),
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
    'eo:bands': [
      {
        name: 'NDVI',
        description: 'Normalized difference vegetation index',
        'gee:scale': 0.0001,
      },
      {
        name: 'TIMEOFDAY',
        description: 'Hours since start of day',
        'gee:units': units.hour,
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
        display_name: 'NDVI',
        lookat: {
          lat: 17.93,
          lon: 7.71,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -1000.0,
            ],
            max: [
              5000.0,
            ],
            palette: [
              'ffffff',
              'ce7e45',
              'fcd163',
              'c6ca02',
              '22cc04',
              '99b718',
              '207401',
              '012e01',
            ],
            bands: [
              'NDVI',
            ],
          },
        },
      },
    ],
    NDVI: {
      minimum: -9998.0,
      maximum: 9998.0,
      'gee:estimated_range': true,
    },
    TIMEOFDAY: {
      minimum: 0.0,
      maximum: 2400.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5PZ56R6',
  'sci:citation': |||
    Eric Vermote, Chris Justice, Ivan Csiszar, Jeff Eidenshink, Ranga Myneni,
    Frederic Baret, Ed Masuoka, Robert Wolfe, Martin Claverie and NOAA CDR
    Program (2014): NOAA Climate Data Record (CDR) of Normalized Difference
    Vegetation Index (NDVI), Version 4. [indicate subset used]. NOAA National
    Climatic Data Center.
    [doi:10.7289/V5PZ56R6](https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.ncdc:C00813)
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
