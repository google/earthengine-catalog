local id = 'LANDSAT/COMPOSITES/C02/T1_L2_32DAY_BAI';
local subdir = 'LANDSAT';
local version = 'COMPOSITES/C02';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local notes = import 'templates/LANDSAT_COMPOSITES_L2.libsonnet';
local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
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
  title: 'Landsat Collection 2 Tier 1 Level 2 32-Day BAI Composite',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    These Landsat Collection 2 Tier 1 Level 2 composites are made from Tier 1 Level 2 orthorectified scenes.

    The Burn Area Index (BAI) is generated from the Red and
    Near-IR bands, and measures the spectral distance of each pixel from a
    reference spectral point (the measured reflectance of charcoal).  This
    index is intended to emphasize the charcoal signal in post-fire
    images. See
    [Chuvieco et al. (2002)](https://www.tandfonline.com/doi/abs/10.1080/01431160210153129) for details.

    These composites are created from
    all the scenes in
    each 32-day period beginning from the first day of the year and
    continuing to the 352nd day of the year.  The last composite of the
    year, beginning on day 353, will overlap the first composite of the
    following year by 20 days.  All the images from each 32-day period are
    included in the composite, with the most recent pixel as the composite value.
  ||| +  notes.description,
  license: license.id,
    links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'bai',
    'landsat',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-01-01T00:00:00Z', null),
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
        lookat: {
          lon: 6.746,
          lat: 46.529,
          zoom: 6,
        },
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
  'gee:interval': {type: 'cadence', unit: 'day', interval: 32},
  'gee:terms_of_use': importstr 'terms_of_use.md',
  'gee:is_derived': true,
}
