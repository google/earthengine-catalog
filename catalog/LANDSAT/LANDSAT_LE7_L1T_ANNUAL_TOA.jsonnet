local id = 'LANDSAT/LE7_L1T_ANNUAL_TOA';
local successor_id = 'LANDSAT/LE07/C01/T1_ANNUAL_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Landsat 7 Annual TOA Reflectance Composite [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 7 composites are made from Level L1T orthorectified scenes, using the
    computed top-of-atmosphere (TOA) reflectance.  See [Chander et al.
    (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
    for details on the TOA computation.

    As of May 1, 2017, the USGS is no longer producing Pre-Collection Landsat, and therefore this collection is complete. Please switch to a Collection 1-based dataset. See [this documentation page](https://developers.google.com/earth-engine/landsat) for more information.

    These composites are created from
    all the scenes in
    each annual period beginning from the first day of the year and
    continuing to the last day of the year.  All the images from each year
    are included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1999-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue',
        center_wavelength: 0.485,
        gsd: 30.0,
        'gee:wavelength': '0.45 - 0.52 &mu;m',
      },
      {
        name: 'B2',
        description: 'Green',
        center_wavelength: 0.56,
        gsd: 30.0,
        'gee:wavelength': '0.52 - 0.60 &mu;m',
      },
      {
        name: 'B3',
        description: 'Red',
        center_wavelength: 0.66,
        gsd: 30.0,
        'gee:wavelength': '0.63 - 0.69 &mu;m',
      },
      {
        name: 'B4',
        description: 'Near infrared',
        center_wavelength: 0.835,
        gsd: 30.0,
        'gee:wavelength': '0.77 - 0.90 &mu;m',
      },
      {
        name: 'B5',
        description: 'Shortwave infrared 1',
        center_wavelength: 1.65,
        gsd: 30.0,
        'gee:wavelength': '1.55 - 1.75 &mu;m',
      },
      {
        name: 'B6_VCID_1',
        description: |||
          Low-gain Thermal Infrared 1. This band has expanded dynamic range
          and lower radiometric resolution (sensitivity), with less
          saturation at high Digital Number (DN) values. Resampled from
          60m to 30m.
        |||,
        center_wavelength: 11.45,
        gsd: 60.0,
        'gee:wavelength': '10.40 - 12.50 &mu;m',
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
        'gee:wavelength': '10.40 - 12.50 &mu;m',
      },
      {
        name: 'B7',
        description: 'Shortwave infrared 2',
        center_wavelength: 2.215,
        gsd: 30.0,
        'gee:wavelength': '2.08 - 2.35 &mu;m',
      },
      {
        name: 'B8',
        description: 'Panchromatic',
        center_wavelength: 0.71,
        gsd: 15.0,
        'gee:wavelength': '0.52 - 0.90 &mu;m',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'True Color (321)',
        image_visualization: {
          band_vis: {
            gamma: [
              1.2,
            ],
            gain: [
              600.0,
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
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
            gamma: [
              1.2,
            ],
            gain: [
              500.0,
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
  'gee:min_zoom_level': 5,
  'gee:interval': {type: 'cadence', unit: 'year', interval: 1},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
  version: ee_const.version_unknown,
}
