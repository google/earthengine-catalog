local id = 'MODIS/MYD09GQ';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD09GQ_versions.libsonnet';

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
  title: 'MYD09GQ.005 Aqua Surface Reflectance Daily L2G Global 250m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Surface Reflectance products
    provide an estimate of the surface spectral reflectance as it would be
    measured at ground level in the absence of atmospheric scattering or
    absorption. Low-level data are corrected for atmospheric gases and
    aerosols, yielding a level-2 basis for several higher-order gridded
    level-2 (L2G) and level-3 products.

    MYD09GQ provides Bands
    1 and 2 at a 250-meter resolution in a daily gridded L2G product in
    the Sinusoidal projection. Science Data Sets provided for this product
    include reflectance for Bands 1 and 2, a quality rating, observation
    coverage, and observation number. This product is meant to be used in
    conjunction with the MOD09GA where important quality and viewing
    geometry information is stored.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'aqua',
    'daily',
    'global',
    'modis',
    'myd09gq',
    'surface_reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/myd09gq'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', '2017-03-30T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'False Color (221)',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'sur_refl_b02',
              'sur_refl_b02',
              'sur_refl_b01',
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
  version: ee_const.version_unknown,
}
