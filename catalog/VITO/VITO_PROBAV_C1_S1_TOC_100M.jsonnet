local id = 'VITO/PROBAV/C1/S1_TOC_100M';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/TOC_100M_versions.libsonnet';

local subdir = 'VITO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'PROBA-V C1 Top Of Canopy Daily Synthesis 100m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Proba-V is a satellite mission tasked to map land cover and vegetation
    growth. It was designed to provide continuity for the VGT optical instrument
    from the SPOT-4 and SPOT-5 missions.

    The sensor collects data in three VNIR (visible and near-infrared) bands
    and one SWIR (short-wave infrared) spectral band with a 2250km field of
    view. Global images are produced every 2 days at 300m resolution, and a 100m
    image from nadir observations every 5 days. These images are later
    composited to produce this daily synthesis dataset. The description of
    the compositing and atmospheric correction procedures can be found in
    the [user manual](https://publications.vito.be/2017-1333-probav-products-user-manual.pdf).

    The reflectances provided in this dataset are presented as Digital Count
    Numbers (DN) and must be converted according to the guidelines in
    Section 4.6.1 of the [user manual](https://publications.vito.be/2017-1333-probav-products-user-manual.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'esa',
    'multispectral',
    'nir',
    'proba',
    'probav',
    'swir',
    'vito',
  ],
  providers: [
    ee.producer_provider('Vito / ESA', 'https://proba-v.vgt.vito.be/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2013-10-17T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'ARCHIVING_DATE',
        description: 'Archiving date',
        type: ee_const.var_type.string,
      },
      {
        name: 'CLOUD_COVER_PERCENTAGE',
        description: 'Cloud cover percentage',
        type: ee_const.var_type.double,
      },
      {
        name: 'LAND_PERCENTAGE',
        description: 'Land percentage',
        type: ee_const.var_type.double,
      },
      {
        name: 'MISSING_DATA_PERCENTAGE',
        description: 'Missing data percentage',
        type: ee_const.var_type.double,
      },
      {
        name: 'PROBAV_ATMCORR_SMAC_VERSION',
        description: 'Initial version of the atmospheric correction algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_CLOUDICESNOWDETECTION_VERSION',
        description: 'Initial version of the cloud and snow/ice detection algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_COMPOSITING_MVC_VERSION',
        description: 'Initial version of the MVC compositing algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_GEOMODELLING_VERSION',
        description: 'Initial version of the geometric modelling algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_MAPPING_VERSION',
        description: 'Initial version of the projection algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_MOSAIC_VERSION',
        description: 'Initial version of the mosaicking algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_RADIOMODELLING_VERSION',
        description: 'Initial version of the radiometric modelling algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROBAV_SHADOWDETECTION_VERSION',
        description: 'Initial version of the shadow detection algorithm',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_VERSION',
        description: 'Product version',
        type: ee_const.var_type.string,
      },
      {
        name: 'SNOW_COVER_PERCENTAGE',
        description: 'Snow cover percentage',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'RED',
        description: 'Top of canopy reflectance RED channel',
        center_wavelength: 0.658,
        full_width_half_max: 0.082,
        'gee:wavelength': '658nm, FWHM: 82nm',
      },
      {
        name: 'NIR',
        description: 'Top of canopy reflectance NIR channel',
        center_wavelength: 0.834,
        full_width_half_max: 0.121,
        'gee:wavelength': '834nm, FWHM: 121nm',
      },
      {
        name: 'BLUE',
        description: 'Top of canopy reflectance BLUE channel',
        center_wavelength: 0.46,
        full_width_half_max: 0.042,
        'gee:wavelength': '460nm, FWHM: 42nm',
      },
      {
        name: 'SWIR',
        description: 'Top of canopy reflectance SWIR channel',
        center_wavelength: 1.61,
        full_width_half_max: 0.089,
        'gee:wavelength': '1610nm, FWHM: 89nm',
      },
      {
        name: 'NDVI',
        description: 'Normalized Difference Vegetation Index',
      },
      {
        name: 'SZA',
        description: 'Solar zenith angle',
        'gee:units': units.degree,
      },
      {
        name: 'SAA',
        description: 'Solar azimuth angle',
        'gee:units': units.degree,
      },
      {
        name: 'SWIRVAA',
        description: 'Viewing azimuth angles SWIR detector',
        'gee:units': units.degree,
      },
      {
        name: 'SWIRVZA',
        description: 'Viewing zenith angle SWIR detector',
        'gee:units': units.degree,
      },
      {
        name: 'VNIRVAA',
        description: 'Viewing azimuth angle VNIR detector',
        'gee:units': units.degree,
      },
      {
        name: 'VNIRVZA',
        description: 'Viewing zenith angle VNIR detector',
        'gee:units': units.degree,
      },
      {
        name: 'SM',
        description: 'Quality / Information band.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cloud/ice snow/shadow flag',
              bit_count: 3,
              values: [
                {
                  description: 'Clear',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Shadow',
                },
                {
                  value: 2,
                  description: 'Undefined',
                },
                {
                  value: 3,
                  description: 'Cloud',
                },
                {
                  value: 4,
                  description: 'Ice',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Land/sea',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'Sea',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Land (pixels with this value may include areas of sea)',
                },
              ],
            },
            {
              description: 'Radiometric quality SWIR flag',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: 'Bad',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
              ],
            },
            {
              description: 'Radiometric quality NIR flag',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'Bad',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
              ],
            },
            {
              description: 'Radiometric quality RED flag',
              first_bit: 6,
              bit_count: 1,
              values: [
                {
                  description: 'Bad',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
              ],
            },
            {
              description: 'Radiometric quality BLUE flag',
              first_bit: 7,
              bit_count: 1,
              values: [
                {
                  description: 'Bad',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Good',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'TIME',
        description: 'Time elapsed since the start of image collection of this mosaic',
        'gee:units': units.minute,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              20.0,
            ],
            max: [
              2000.0,
            ],
            bands: [
              'RED',
              'NIR',
              'BLUE',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': 'Copyright ESA-BELSPO, produced by Vito',
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': 'PROBA-V 300m and 100m data are freely available for data older than 1 month.',
}
