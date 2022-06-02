local id = 'LANDSAT/GLS1975';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  ],
  id: id,
  title: 'Landsat Global Land Survey 1975 Mosaic',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Land Survey (GLS) 1975 is a
    global collection of imagery from the Landsat Multispectral
    Scanner (MSS).  Most scenes were acquired by Landsat 1-3
    in 1972-1983.  A few gaps in the Landsat 1-3 data
    have been filled with scenes acquired by Landsat 4-5 during the
    years 1982-1987.  These data contain 4 spectral bands:
    Green, Red, an NIR band, and a SWIR band.  In the typical
    False-color presentation, the images appear red because
    the NIR band, displayed as red, highlights vegetation.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'global',
    'gls',
    'landsat',
    'radiance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/core-science-systems/nli/landsat/global-land-survey-gls'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1972-07-25T00:00:00Z', '1983-02-20T00:00:00Z'),
  summaries: {
    gsd: [
      60.0,
    ],
    'eo:bands': [
      {
        name: '10',
        description: 'Green',
        center_wavelength: 0.55,
        'gee:wavelength': '500-600 nm',
      },
      {
        name: '20',
        description: 'Red',
        center_wavelength: 0.65,
        'gee:wavelength': '600-700 nm',
      },
      {
        name: '30',
        description: 'Near infrared',
        center_wavelength: 0.75,
        'gee:wavelength': '700-800 nm',
      },
      {
        name: '40',
        description: 'Short-wavelength infrared',
        center_wavelength: 0.95,
        'gee:wavelength': '800-1100 nm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lat: 25.998,
          lon: 44.517,
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
  'sci:citation': 'GLS 1975 image courtesy of the U.S. Geological Survey',
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
