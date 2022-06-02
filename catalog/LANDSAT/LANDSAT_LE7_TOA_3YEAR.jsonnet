local id = 'LANDSAT/LE7_TOA_3YEAR';
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
  title: 'Landsat 7 3-year TOA percentile composites',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These 3-year composites were created
      from all Landsat 7 images in the specified composite period, excluding
      images marked with a negative sun elevation in their metadata.  The
      composites were created using
      the [ee.Algorithms.Landsat.simpleComposite()](https://developers.google.com/earth-engine/landsat#simple-composite)
      method with its default settings.
      Reflectance ([0,1]) in bands B1, B2, B3, B4, B5, and B7 is scaled to 8 bits
      ([0,255]) and temperature in band B6_VCID_2 is converted to units of
      Kelvin-100.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'etm',
    'global',
    'l7',
    'landsat',
    'le7',
    'percentile',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2012-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 µm',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 µm',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 µm',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.77 - 0.90 µm',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 µm',
      },
      {
        name: 'B6_VCID_2',
        description: |||
          High-gain Thermal Infrared 1. This band has higher radiometric
          resolution (sensitivity), although it has a more restricted dynamic range.
          Resampled from 60m to 30m.
        |||,
        center_wavelength: 11.45,
        gsd: 60.0,
        'gee:wavelength': '10.40 - 12.50 µm',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 µm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              120.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
      {
        display_name: 'Near Infrared (432)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              120.0,
            ],
            bands: [
              'B4',
              'B3',
              'B2',
            ],
          },
        },
      },
      {
        display_name: 'Shortwave Infrared (742)',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              120.0,
            ],
            bands: [
              'B7',
              'B4',
              'B2',
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
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
}
