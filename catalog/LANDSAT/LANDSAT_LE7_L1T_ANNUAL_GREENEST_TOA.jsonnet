local id = 'LANDSAT/LE7_L1T_ANNUAL_GREENEST_TOA';
local successor_id = 'LANDSAT/LE07/C01/T1_ANNUAL_GREENEST_TOA';
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

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Landsat 7 Annual Greenest-Pixel TOA Reflectance Composite [deprecated]',
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
    are included in the composite, with the greenest pixel as the composite value, where
    the greenest pixel means the pixel with the highest value of
    the Normalized Difference Vegetation Index (NDVI).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'greenest',
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'http://landsat.usgs.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1999-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
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
