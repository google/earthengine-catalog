local id = 'NOAA/VIIRS/DNB/ANNUAL_V21';
local subdir = 'NOAA';

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
  title: 'VIIRS Nighttime Day/Night Annual Band Composites V2.1',
  version: 'V2.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Annual global VIIRS nighttime lights dataset is a time series produced from
    monthly cloud-free average radiance grids spanning 2013 to 2021.
    Data for 2022 are available in the
    [NOAA/VIIRS/DNB/ANNUAL_V22](NOAA_VIIRS_DNB_ANNUAL_V22) dataset.

    An initial filtering step removed sunlit, moonlit and cloudy pixels,
    leading to rough composites that contains lights, fires, aurora and
    background. The rough annual composites are made on monthly increments and
    then combined to form rough annual composites.

    The subsequent steps uses the twelve-month median radiance to discard high
    and low radiance outliers, filtering out most fires and isolating the
    background. Background areas are zeroed out using the data range (DR)
    calculated from 3x3 grid cells. The DR threshold for background is indexed
    to cloud-cover levels, with higher DR thresholds in areas having low numbers
    of cloud-free coverages.

    Note: 2012 data are not yet included because of differences in processing.
    (A) 201204-201212, and (B) 201204-201303. Only set (B) has masked median
    and average bands which doesn't follow the pattern there in other year
    datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'annual',
    'dnb',
    'eog',
    'lights',
    'nighttime',
    'noaa',
    'viirs',
    'visible',
  ],
  providers: [
    ee.producer_provider('Earth Observation Group, Payne Institute for Public Policy, Colorado School of Mines', 'https://eogdata.mines.edu/products/vnl/#annual_v2'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -65.0, 180.0, 75.0, '2012-04-01T00:00:00Z', null),
  summaries: {
    gsd: [
      463.83,
    ],
    'eo:bands': [
      {
        name: 'average',
        description: 'Average DNB radiance values.',
        'gee:units': units.radiance_nanowatts_cm2,
      },
      {
        name: 'average_masked',
        description: 'Average Masked DNB radiance values',
        'gee:units': units.radiance_nanowatts_cm2,
      },
      {
        name: 'cf_cvg',
        description: |||
          Cloud-free coverages; the total number of observations that
          went into each pixel. This band can be used to identify areas with low
          numbers of observations where the quality is reduced.
        |||,
      },
      {
        name: 'cvg',
        description: |||
          Total number of observations free of sunlight and moonlight.
        |||,
      },
      {
        name: 'maximum',
        description: 'Maximum DNB radiance values.',
        'gee:units': units.radiance_nanowatts_cm2,
      },
      {
        name: 'median',
        description: 'Median DNB radiance values',
        'gee:units': units.radiance_nanowatts_cm2,
      },
      {
        name: 'median_masked',
        description: 'Median masked DNB radiance values.',
        'gee:units': units.radiance_nanowatts_cm2,
      },
      {
        name: 'minimum',
        description: 'Minimum DNB radiance values',
        'gee:units': units.radiance_nanowatts_cm2,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Nighttime',
        lookat: {
          lat: 45.83,
          lon: 1.76,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              60.0,
            ],
            bands: [
              'maximum',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.3390/rs13050922',
  'sci:citation': |||
    Elvidge, C.D, Zhizhin, M., Ghosh T., Hsu FC, Taneja J. Annual time series of
    global VIIRS nighttime lights derived from monthly averages:2012 to 2019.
    Remote Sensing 2021, 13(5), p.922, doi:10.3390/rs13050922
    [doi:10.3390/rs13050922](https://doi.org/10.3390/rs13050922)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Colorado School of Mines data, information, and products,
    regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution.
  |||,
}
