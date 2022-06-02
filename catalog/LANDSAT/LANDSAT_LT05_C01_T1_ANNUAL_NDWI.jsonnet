local id = 'LANDSAT/LT05/C01/T1_ANNUAL_NDWI';
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
  title: 'Landsat 5 TM Collection 1 Tier 1 Annual NDWI Composite',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat 5 TM Collection 1 Tier 1 composites are made from Tier 1 orthorectified scenes, using the
      computed top-of-atmosphere (TOA) reflectance.
      See [Chander et al. (2009)](https://www.sciencedirect.com/science/article/pii/S0034425709000169)
      for details on the TOA computation.

    The Normalized Difference Water Index (NDWI) is sensitive
    to changes in liquid water content of vegetation canopies.  It is
    derived from the Near-IR band and a second IR band, &approx;1.24&mu;m when
    available and the nearest available IR band otherwise.  It ranges in
    value from -1.0 to 1.0.  See
    [Gao (1996)](https://www.sciencedirect.com/science/article/pii/S0034425796000673)
    for details.

    These composites are created from
    all the scenes in
    each annual period beginning from the first day of the year and
    continuing to the last day of the year.  All the images from each year
    are included in the composite, with the most recent pixel as the composite value.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'landsat',
    'ndwi',
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
        name: 'NDWI',
        description: 'Normalized Difference Water Index',
        gsd: 30.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Colorized',
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
              'ffffff',
            ],
            bands: [
              'NDWI',
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
