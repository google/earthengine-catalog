local id = 'LANDSAT/LT05/C01/T1_ANNUAL_NBRT';
local successor_id = 'LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_NBR';
local subdir = 'LANDSAT';
local latest_id = successor_id;
local version = 'LT05/C01';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
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
  version: version,
  deprecated: true,
  title: 'Landsat 5 TM Collection 1 Tier 1 Annual NBRT Composite [deprecated]',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 5 TM Collection 1 Tier 1 composites are made from Tier 1 orthorectified scenes, using the
      computed top-of-atmosphere (TOA) reflectance.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.

    The Normalized Burn Ratio Thermal (NBRT) index is
    generated from the Near-IR, Mid-IR (2215 nm), and Thermal bands, and
    has a range from -1.0 to 1.0. See
    [Holden et al. (2005)](https://www.tandfonline.com/doi/abs/10.1080/01431160500239008)
    for details.

    These composites are created from
    all the scenes in
    each annual period beginning from the first day of the year and
    continuing to the last day of the year.  All the images from each year
    are included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + '.json'),
    ee.link.successor(
      successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'landsat',
    'nbrt',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-01-01T00:00:00Z', '2012-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'NBRT',
        description: 'Normalized Burn Ratio Thermal',
        gsd: 30.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Colorized',
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.9,
            ],
            max: [
              1.0,
            ],
            palette: [
              '000000',
              'ffffff',
            ],
            bands: [
              'NBRT',
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
}
