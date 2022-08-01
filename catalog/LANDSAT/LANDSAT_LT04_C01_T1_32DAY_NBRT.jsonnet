local id = 'LANDSAT/LT04/C01/T1_32DAY_NBRT';
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
  ],
  id: id,
  title: 'Landsat 4 TM Collection 1 Tier 1 32-Day NBRT Composite',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 4 TM Collection 1 Tier 1 composites are made from Tier 1 orthorectified scenes, using the
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
    each 32-day period beginning from the first day of the year and
    continuing to the 352nd day of the year.  The last composite of the
    year, beginning on day 353, will overlap the first composite of the
    following year by 20 days.  All the images from each 32-day period are
    included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'landsat',
    'nbrt',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1982-08-13T00:00:00Z', '1993-11-17T00:00:00Z'),
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
              'FFFFFF',
            ],
            bands: [
              'NBRT',
            ],
          },
        },
      },
    ],
  },
  'gee:min_zoom_level': 4,
  'gee:interval': {type: 'cadence', unit: 'day', interval: 32},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
}
