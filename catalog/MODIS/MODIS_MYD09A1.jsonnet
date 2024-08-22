local id = 'MODIS/MYD09A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD09A1_versions.libsonnet';

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
  title: 'MYD09A1.005 Surface Reflectance 8-Day L3 Global 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Surface Reflectance products
    provide an estimate of the surface spectral reflectance as it would be
    measured at ground level in the absence of atmospheric scattering or
    absorption. Low-level data are corrected for atmospheric gases and
    aerosols, yielding a level-2 basis for several higher-order gridded
    level-2 (L2G) and level-3 products.

    MYD09A1 provides
    Bands 1-7 at 500-meter resolution in an 8-day gridded level-3 product in the
    Sinusoidal projection. Each MYD09A1 pixel contains the best possible L2G
    observation during an 8-day period as selected on the basis of high observation
    coverage, low view angle, the absence of clouds or cloud shadow, and aerosol
    loading. Science Data Sets provided for this product include reflectance values
    for Bands 1-7, quality assessment, and the day of the year for the pixel along
    with solar, view, and zenith angles.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    '8_day',
    'aqua',
    'global',
    'modis',
    'myd09a1',
    'surface_reflectance',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/myd09a1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', '2017-03-22T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'True Color (143)',
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
              'sur_refl_b01',
              'sur_refl_b04',
              'sur_refl_b03',
            ],
          },
        },
      },
      {
        display_name: 'False Color (367: Snow/Water/Ice)',
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
              'sur_refl_b03',
              'sur_refl_b06',
              'sur_refl_b07',
            ],
          },
        },
      },
      {
        display_name: 'False Color (721: Burns)',
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
              'sur_refl_b07',
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
