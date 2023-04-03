local id = 'NOAA/CDR/AVHRR/LAI_FAPAR/V4';
local successor_id = 'NOAA/CDR/AVHRR/LAI_FAPAR/V5';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
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
  title: 'NOAA CDR AVHRR LAI FAPAR: Leaf Area Index and Fraction of Absorbed Photosynthetically Active Radiation, Version 4 [deprecated]',
  version: '4',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA Climate Data Record (CDR) of AVHRR Leaf Area Index (LAI) and
    Fraction of Absorbed Photosynthetically Active Radiation (FAPAR) dataset
    contains derived values that characterize the canopy and photosynthetic
    activity of plants. This dataset is derived from the NOAA AVHRR Surface
    Reflectance product and is gridded at a resolution of 0.05° on a daily
    basis. The values are computed globally over land surfaces, but not over
    bare or very sparsely vegetated areas, permanent ice or snow, permanent
    wetland, urban areas, or water bodies.

    Known issues with this dataset include:

    - TIMEOFDAY variable contains values that are too large by 1 day

    - Latitude values are not correctly associated with the center of
      the grid cell, error is < 0.002 degrees

    - Longitude values are not correctly associated with the center of
      the grid cell, error is < 0.02 degrees

    See [technical note from the data provider](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/AVHRR%20Surface%20Reflectance/TechNote.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5M043BX',
    },
  ],
  keywords: [
    'avhrr',
    'cdr',
    'daily',
    'fapar',
    'lai',
    'land',
    'noaa',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncdc.noaa.gov/cdr/terrestrial/leaf-area-index-and-fapar'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1981-06-24T00:00:00Z', '2019-05-16T00:00:00Z'),
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
        name: 'LAI',
        description: 'Leaf area index',
        'gee:scale': 0.001,
      },
      {
        name: 'FAPAR',
        description: 'Fraction of absorbed photosynthetic active radiation',
        'gee:scale': 0.001,
      },
      {
        name: 'QA',
        description: 'Quality control bit flags',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Quality control',
              bit_count: 2,
              values: [
                {
                  description: 'Ok',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Input flags as cloudy',
                },
                {
                  value: 2,
                  description: 'Invalid input',
                },
                {
                  value: 3,
                  description: 'Output out of range',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Associated class',
              first_bit: 2,
              bit_count: 3,
              values: [
                {
                  value: 1,
                  description: 'Needleleaf forest',
                },
                {
                  value: 2,
                  description: 'Broadleaf forest',
                },
                {
                  value: 4,
                  description: 'Grassland & croplands & non vegetated',
                },
                {
                  value: 5,
                  description: 'Evergreen broadleaf forest',
                },
                {
                  value: 6,
                  description: 'Water',
                },
              ],
            },
            {
              description: 'BRDF corrected',
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
              description: 'Polygon test',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'In polygon',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Not in polygon',
                },
                {
                  value: 2,
                  description: 'Not tested (water/cloudy)',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Leaf Area Index',
        lookat: {
          lat: -60.5,
          lon: -20.0,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              4000.0,
            ],
            palette: [
              '3b0200',
              '977705',
              'ca9f06',
              'ffca09',
              '006a03',
              '003b02',
            ],
            bands: [
              'LAI',
            ],
          },
        },
      },
    ],
    LAI: {
      minimum: 0.0,
      maximum: 6205.0,
      'gee:estimated_range': true,
    },
    FAPAR: {
      minimum: 0.0,
      maximum: 896.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5M043BX',
  'sci:citation': |||
    Martin Claverie, Eric Vermote, and NOAA CDR Program (2014): NOAA Climate
    Data Record (CDR) of Leaf Area Index (LAI) and Fraction of Absorbed
    Photosynthetically Active Radiation (FAPAR), Version 4. [indicate subset
    used]. NOAA National Climatic Data Center.
    [doi:10.7289/V5M043BX](https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.ncdc:C00898)
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
