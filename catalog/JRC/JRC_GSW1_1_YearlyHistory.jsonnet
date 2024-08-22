local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local versions = import 'versions.libsonnet';
local version_table = import 'JRC_GSW_YearlyHistory_version_map.libsonnet';

local subdir = 'JRC';
local id = 'JRC/GSW1_1/YearlyHistory';
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
  title: 'JRC Yearly Water Classification History, v1.1 [deprecated]',
  version: '1.1',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset contains maps of the location and temporal
    distribution of surface water from 1984 to 2018 and provides
    statistics on the extent and change of those water surfaces.
    For more information see the associated journal article: [High-resolution
    mapping of global surface water and its long-term changes](https://www.nature.com/nature/journal/v540/n7633/full/nature20584.html)
    (Nature, 2016) and the online [Data Users Guide](https://storage.googleapis.com/global-surface-water/downloads_ancillary/DataUsersGuidev2.pdf).

    These data were generated using 3,865,618 scenes from Landsat
    5, 7, and 8 acquired between 16 March 1984 and 31 December 2018.
    Each pixel was individually classified into water / non-water
    using an expert system and the results were collated into a monthly
    history for the entire time period and two epochs (1984-1999,
    2000-2018) for change detection.

    This Yearly Seasonality Classification collection contains a year-by-year
    classification of the seasonality of water based on the occurrence values
    detected throughout the year.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) +
  version_config.version_links,
  keywords: [
    'annual',
    'geophysical',
    'google',
    'history',
    'jrc',
    'landsat_derived',
    'surface',
    'water',
    'yearly',
  ],
  providers: [
    ee.producer_provider('EC JRC / Google', 'https://global-surface-water.appspot.com'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -59.0, 180.0, 78.0,
                    '1984-03-16T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'waterClass',
        description: 'Classification of the seasonality of water throughout the year.',
        'gee:classes': [
          {
            color: 'cccccc',
            description: 'No data',
            value: 0,
          },
          {
            value: 1,
            color: 'ffffff',
            description: 'Not water',
          },
          {
            value: 2,
            color: '99d9ea',
            description: 'Seasonal water',
          },
          {
            value: 3,
            color: '0000ff',
            description: 'Permanent water',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water Class',
        lookat: {
          lat: 45.182,
          lon: 59.414,
          zoom: 7,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3.0,
            ],
            palette: [
              'cccccc',
              'ffffff',
              '99d9ea',
              '0000ff',
            ],
            bands: [
              'waterClass',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Jean-Francois Pekel, Andrew Cottam, Noel Gorelick, Alan S. Belward,
    High-resolution mapping of global surface water and its long-term changes.
    Nature 540, 418-422 (2016). ([doi:10.1038/nature20584](https://doi.org/10.1038/nature20584))
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    All data here is produced under the Copernicus Programme and is provided
    free of charge, without restriction of use. For the full license
    information see the Copernicus Regulation.

    Publications, models, and data products that make use of these datasets
    must include proper acknowledgement, including citing datasets and the
    journal article as in the following citation.

    If you are using the data as a layer in a published map, please include the
    following attribution text: 'Source: EC JRC/Google'
  |||,
  'gee:user_uploaded': true,
}
