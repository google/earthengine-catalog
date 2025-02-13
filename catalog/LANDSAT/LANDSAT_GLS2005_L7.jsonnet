local id = 'LANDSAT/GLS2005_L7';
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
  title: 'Landsat Global Land Survey 2005, Landsat 7 scenes',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GLS2005 data set is a collection of 9500
    orthorectified leaf-on medium-resolution satellite images collected between
    2004 and 2007 and covering the Earth's land masses. GLS2005 uses mainly Landsat
    5 and gap-filled Landsat 7 data with EO-1 ALI and Terra ASTER data filling in
    any data holes.

    This collection contains just the subset of the GLS2005 images
          from the L7 ETM+ sensor.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'etm',
    'gls',
    'l7',
    'landsat',
    'radiance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://www.usgs.gov/landsat-missions/global-land-survey-gls'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2003-07-29T00:00:00Z', '2008-07-29T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: '10',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: '20',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: '30',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: '40',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.76 - 0.90 &mu;m',
      },
      {
        name: '50',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: '60',
        description: 'Thermal Infrared 1. Resampled from 60m to 30m.',
        center_wavelength: 11.45,
        gsd: 60.0,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: '70',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.0,
            ],
            bands: [
              '30',
              '20',
              '10',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (432)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.4,
              1.2,
              1.4,
            ],
            bands: [
              '40',
              '30',
              '20',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (742)',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            gain: [
              1.8,
              1.9,
              1.9,
            ],
            bands: [
              '70',
              '40',
              '20',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
