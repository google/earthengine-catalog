local id = 'CIESIN/GPWv4/ancillary-data-grids';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/CIESIN_land_area_versions.libsonnet';

local subdir = 'CIESIN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GPWv4: Gridded Population of the World Version 4, Ancillary Data Grids [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Gridded Population of World Version 4 (GPWv4) models the distribution
    of global human population for the years 2000, 2005, 2010, 2015, and 2020
    on 30 arc-second (approximately 1km) grid cells. Population is distributed
    to cells using proportional allocation of population from census and
    administrative units. Population input data are collected at the most
    detailed spatial resolution available from the results of the 2010 round of
    censuses, which occurred between 2005 and 2014. The input data are
    extrapolated to produce population estimates for each modeled year.

    These ancillary data grids contain additional per-pixel data that can be
    used to assess the quality of the population estimates and how they were
    produced.

    [General Documentation](https://beta.sedac.ciesin.columbia.edu/data/set/gpw-v4-land-water-area/docs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7927/H4F47M2C',
    },
  ] + version_config.version_links,
  keywords: [
    'ciesin',
    'gpw',
    'population',
  ],
  providers: [
    ee.producer_provider('CIESIN', 'https://sedac.ciesin.columbia.edu/data/collection/gpw-v4'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1417149701-SEDAC',
    'C1418717760-SEDAC',
    'C1418732711-SEDAC',
    'C1427612908-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'water-mask',
        description: 'Water mask',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Identifies water pixels; non-water pixels are masked',
              bit_count: 1,
              values: [
                {
                  description: 'Total water pixels that are completely water and/or permanent ice.',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Partial water pixels that also contain land.',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
      {
        name: 'data-context',
        description: |||
          Categorizes pixels with estimated zero population based on
          information provided in the census documents.
        |||,
        'gee:classes': [
          {
            value: 201,
            color: '099506',
            description: 'Park or protected area.',
          },
          {
            value: 202,
            color: 'ff0b00',
            description: 'Military district, airport zone, or other infrastructure.',
          },
          {
            value: 203,
            color: '060606',
            description: 'Not enumerated or not reported in census.',
          },
          {
            value: 204,
            color: 'a5a5a5',
            description: 'No households.',
          },
          {
            value: 205,
            color: 'ffe152',
            description: 'Uninhabited.',
          },
        ],
      },
      {
        name: 'mean-administrative-unit-area',
        description: 'The mean area of the input unit(s) from which population count\nand density grids are created.',
        'gee:units': units.square_km,
      },
      {
        name: 'national-identifier',
        description: |||
          An integer that represents the census data source used
          to produce the GPWv4 population estimates. Pixels (grid cells) that have
          the same value reflect the same data source, most often a country or
          territory. Note that these data represent the area covered by the
          statistical data as provided, and are not official representations of
          country or territory boundaries.
        |||,
      },
      {
        name: 'land-area',
        description: 'Estimate of the land area, excluding permanent ice and water, within each 30 arc-second pixel.',
        'gee:units': units.square_km,
      },
      {
        name: 'water-area',
        description: 'Estimate of the water area (permanent ice and water) within each 30 arc-second pixel.',
        'gee:units': units.square_km,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Zero Population Areas',
        lookat: {
          lat: 10.0,
          lon: 26.4,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              201.0,
            ],
            max: [
              205.0,
            ],
            palette: [
              '099506',
              'ff0b00',
              '060606',
              'a5a5a5',
              'ffe152',
            ],
            bands: [
              'data-context',
            ],
          },
        },
      },
    ],
    'mean-administrative-unit-area': {
      minimum: 0.0,
      maximum: 816831.0,
      'gee:estimated_range': true,
    },
    'national-identifier': {
      minimum: 4.0,
      maximum: 999.0,
      'gee:estimated_range': true,
    },
    'land-area': {
      minimum: 0.0,
      maximum: 0.86,
      'gee:estimated_range': true,
    },
    'water-area': {
      minimum: 0.0,
      maximum: 0.86,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4F47M2C',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2016. Gridded Population of the World, Version 4
    (GPWv4): Administrative Unit Center Points with Population Estimates.
    Palisades, NY: NASA Socioeconomic Data and Applications Center
    (SEDAC). [https://doi.org/10.7927/H4F47M2C](https://doi.org/10.7927/H4F47M2C).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
