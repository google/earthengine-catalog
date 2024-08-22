local id = 'MODIS/MOD09Q1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD09Q1_versions.libsonnet';

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
  title: 'MOD09Q1.005 Surface Reflectance 8-Day Global 250m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Surface Reflectance products
    provide an estimate of the surface spectral reflectance as it would be
    measured at ground level in the absence of atmospheric scattering or
    absorption. Low-level data are corrected for atmospheric gases and
    aerosols, yielding a level-2 basis for several higher-order gridded
    level-2 (L2G) and level-3 products.

    MOD09Q1 provides Bands 1
    and 2 at 250-meter resolution in an 8-day gridded level-3 product in the
    Sinusoidal projection. Each MOD09Q1 pixel contains the best possible L2G
    observation during an 8-day period as selected on the basis of
    high observation coverage, low view angle, the absence of clouds or cloud
    shadow, and aerosol loading. Science Data Sets provided for this product
    include reflectance values for Bands 1 and 2, and a quality rating.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    '8_day',
    'global',
    'mod09q1',
    'modis',
    'surface_reflectance',
    'terra',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod09q1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', '2017-03-22T00:00:00Z'),
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
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: ee_const.version_unknown,
}
