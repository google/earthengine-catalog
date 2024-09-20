local id = 'LANDSAT/GLS1975_MOSAIC';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Landsat Global Land Survey 1975 Mosaic',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Land Survey (GLS) 1975 is a
    global collection of imagery from the Landsat Multispectral Scanner
    (MSS).  Most scenes were acquired by Landsat 1&ndash;3 during the
    years from 1972&ndash;1983.  A few gaps in the Landsat 1&ndash;3 data
    have been filled with scenes acquired by Landsat 4&ndash;5 during the
    years 1982&ndash;1987.

    These data contain 4 spectral bands:
    Green, Red, an NIR band, and a SWIR band.  In the typical false-color
    presentation the images appear red because the NIR band, displayed as
    red, highlights vegetation.

    All scenes in the collection are included in this composite image.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'gls',
    'landsat',
    'radiance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/landsat-missions/global-land-survey-gls'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '1976-01-01T00:00:00Z'),
  summaries: {
    gsd: [60],
    'eo:bands': [
      {
        name: '10',
        description: 'Green',
        center_wavelength: 0.55,
        'gee:wavelength': '0.50 - 0.60 &mu;m',
      },
      {
        name: '20',
        description: 'Red',
        center_wavelength: 0.65,
        'gee:wavelength': '600-700 &mu;m',
      },
      {
        name: '30',
        description: 'Near infrared',
        center_wavelength: 0.75,
        'gee:wavelength': '0.70-0.80 &mu;m',
      },
      {
        name: '40',
        description: 'Short-wavelength infrared',
        center_wavelength: 0.95,
        'gee:wavelength': '0.80-1.10 &mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lon: 44.517,
          lat: 25.998,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            gamma: [
              1.6,
            ],
            gain: [
              1.4,
            ],
            bands: [
              '30',
              '20',
              '10',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:min_zoom_level': 6,
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
}
