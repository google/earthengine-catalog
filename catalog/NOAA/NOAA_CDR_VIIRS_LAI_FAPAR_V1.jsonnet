local id = 'NOAA/CDR/VIIRS/LAI_FAPAR/V1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/VIIRS_LAI_FAPAR_versions.libsonnet';

local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
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
  title: 'NOAA CDR VIIRS LAI FAPAR: Leaf Area Index and Fraction of Absorbed Photosynthetically Active Radiation, Version 1',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This Climate Data Record (CDR) combines datasets for Leaf Area Index (LAI)
    and Fraction of Absorbed Photosynthetically Active Radiation (FAPAR), two
    biophysical variables that can be used to evaluate vegetation stress,
    forecast agricultural yields, and other modeling and resource management
    applications. LAI tracks the one-sided green leaf area per unit of ground
    surface area, while FAPAR quantifies the solar radiation absorbed by plants
    within the photosynthetically active radiation (PAR) spectral region.
    The LAI/FAPAR CDR generates a daily product on a .05&deg; by .05&deg; grid.
    The data is generated from the Visible Infrared Imaging Radiometer Suite
    (VIIRS) sensors from 2014 onward.

    Known issues with this dataset include:

    - TIMEOFDAY variable contains values that are too large by 1 day

    - Latitude values are not correctly associated with the center of
      the grid cell, error is < 0.002 degrees

    - Longitude values are not correctly associated with the center of
      the grid cell, error is < 0.02 degrees

    See [technical note from the data provider](https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/Leaf_Area_Index_and_FAPAR/VIIRS/AlgorithmDescriptionVIIRS_01B-20c.pdf).

    Provider's note: the orbital drift of N-19 (the last NOAA satellite
    carrying the AVHRR sensor) began to severely degrade the retrieved
    product quality. Therefore, VIIRS is now the primary sensor being used for
    these products from 2014-present.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.25921/9x3m-0e02',
    },
  ],
  'gee:categories': ['plant-productivity'],
  keywords: [
    'viirs',
    'cdr',
    'daily',
    'fapar',
    'lai',
    'land',
    'noaa',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncei.noaa.gov/products/climate-data-records/leaf-area-index-and-fapar'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2014-01-01T00:00:00Z', null),
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
  'sci:doi': '10.25921/9x3m-0e02',
  'sci:citation': |||
    Cite as: Claverie, Martin; Vermote, Eric; Justice, Chris; Csiszar, Ivan;
    Myneni, Ranga; Baret, Frederic; Masuoka, Ed; Wolfe, Robert; Ray, James P.;
    NOAA CDR Program. (2023): NOAA Climate Data Record (CDR) of VIIRS Leaf Area
    Index (LAI) and Fraction of Absorbed Photosynthetically Active Radiation
    (FAPAR), Version 1. [indicate subset used]. NOAA National Centers for
    Environmental Information. [https://doi.org/10.25921/9x3m-0e02](https://www.ncei.noaa.gov/metadata/geoportal/rest/metadata/item/gov.noaa.ncdc:C01706/html).
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
