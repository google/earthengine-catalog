local id = 'MODIS/MYD09GA_BAI';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD09GA_BAI_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MODIS Aqua Daily BAI [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Burn Area Index (BAI) is generated from the Red and
    Near-IR bands, and measures the spectral distance of each pixel from a
    reference spectral point (the measured reflectance of charcoal).  This
    index is intended to emphasize the charcoal signal in post-fire
    images. See
    [Chuvieco et al. (2002)](https://www.tandfonline.com/doi/abs/10.1080/01431160210153129)
    for details. This product is generated from the MODIS/MYD09GA surface reflectance composites.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'bai',
    'modis',
    'usgs',
  ],
  providers: [
    ee.producer_provider('Google', 'https://earthengine.google.com/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', '2017-03-30T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'BAI',
        description: 'Burn Area Index',
        gsd: 463.312716528,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Scaled',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
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
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  'gee:is_derived': true,
  version: ee_const.version_unknown,
}
