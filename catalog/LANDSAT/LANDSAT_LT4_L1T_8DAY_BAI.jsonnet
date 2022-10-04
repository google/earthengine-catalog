local id = 'LANDSAT/LT4_L1T_8DAY_BAI';
local successor_id = 'LANDSAT/LT04/C01/T1_8DAY_BAI';
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
  title: 'Landsat 4 TM 8-Day BAI Composite [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 4 TM composites are made from Level L1T orthorectified scenes, using the
    computed top-of-atmosphere (TOA) reflectance.  See [Chander et al.
    (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
    for details on the TOA computation.

    As of May 1, 2017, the USGS is no longer producing Pre-Collection Landsat, and therefore this collection is complete. Please switch to a Collection 1-based dataset. See [this documentation page](https://developers.google.com/earth-engine/landsat) for more information.

    The Burn Area Index (BAI) is generated from the Red and
    Near-IR bands, and measures the spectral distance of each pixel from a
    reference spectral point (the measured reflectance of charcoal).  This
    index is intended to emphasize the charcoal signal in post-fire
    images. See
    [Chuvieco et al. (2002)](https://www.tandfonline.com/doi/abs/10.1080/01431160210153129)
    for details.

    These composites are created from
    all the scenes in each
    8-day period beginning from the first day of the year and continuing
    to the 360th day of the year.  The last composite of the year,
    beginning on day 361, will overlap the first composite of the
    following year by 3 days.  All the images from each 8-day period are
    included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'bai',
    'landsat',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://landsat.usgs.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1982-08-21T00:00:00Z', '1993-12-11T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'BAI',
        description: 'Burn Area Index',
        gsd: 30.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Scaled',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              100.0,
            ],
            bands: [
              'BAI',
            ],
          },
        },
      },
    ],
  },
  'gee:min_zoom_level': 4,
  'gee:interval': {type: 'cadence', unit: 'day', interval: 8},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
  version: ee_const.version_unknown,
}
