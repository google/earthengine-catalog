local id = 'MODIS/061/MOD08_M3';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD08_M3_versions.libsonnet';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD08_M3.061 Terra Atmosphere Monthly Global Product',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    MOD08_M3 V6.1 is an atmosphere global product that contains
    monthly 1 x 1 degree grid average values of atmospheric parameters.
    These parameters are related to atmospheric aerosol particle properties,
    total ozone burden, atmospheric water vapor, cloud optical and
    physical properties, and atmospheric stability indices. The product
    also provides means, standard deviations, QA weighted statistics,
    log-normal distributions, uncertainty estimates, and statistics
    for fractions of pixels that satisfy some condition. Below is a
    subset of the bands, for a complete list see the [MOD08 Band List](https://developers.google.com/earth-engine/MOD08_bands.html).

    Documentation:

    * [User's Guide](https://modis-atmos.gsfc.nasa.gov/sites/default/files/ModAtmo/L3_ATBD_C6_C61_2019_02_20.pdf)

    * [Science Data Product Software Documentation](https://modis-atmos.gsfc.nasa.gov/sites/default/files/ModAtmo/L3_C61_Changes_v2.pdf)

    * [MYD08_M3 product description](https://modis-atmos.gsfc.nasa.gov/products/monthly)

    * [File specification document](https://modis-atmos.gsfc.nasa.gov/sites/default/files/ModAtmo/MOD08_M3_fs_3045.txt)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD08_M3.061',
    },
  ] + version_config.version_links,
  keywords: [
    'atmosphere',
    'geophysical',
    'global',
    'mod08',
    'mod08_m3',
    'modis',
    'monthly',
    'nasa',
    'temperature',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LAADS DAAC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/MODIS/MOD08_M3.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1443766359-LAADS',
  ],
  extent: ee.extent_global('2000-02-01T00:00:00Z', null),
  summaries: {
    gsd: [
      111320.0,
    ],
    platform: [
      'Terra',
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Aerosol_Optical_Depth_Land_Ocean_Mean_Mean',
        description: |||
          Aerosol optical thickness at 0.55 microns for both
          ocean (best) and land (corrected): mean of daily mean
        |||,
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_Ocean_Std_Deviation_Mean',
        description: |||
          Aerosol optical thickness at 0.55 microns for both
          ocean (best) and land (corrected): mean of daily standard deviation
        |||,
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_QA_Mean_Mean_470',
        description: 'Corrected aerosol optical depth (land) at 0.47 microns:\nmean of level-3 QA weighted mean',
        'gee:scale': 0.001,
      },
      {
        name: 'Aerosol_Optical_Depth_Land_QA_Std_Deviation_Mean_470',
        description: 'Corrected aerosol optical depth (land) at 0.47 microns:\nmean of level-3 weighted QA standard deviation',
        'gee:scale': 0.001,
      },
      {
        name: 'Cirrus_Fraction_SWIR_FMean',
        description: 'Cirrus area fraction: mean of daily fraction',
        'gee:scale': 0.0001,
      },
      {
        name: 'Cirrus_Fraction_SWIR_FStd',
        description: 'Cirrus area fraction: standard deviation of daily fraction',
        'gee:scale': 0.0001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Mean_Mean',
        description: 'Liquid water cloud optical thickness: mean of daily log mean',
        'gee:scale': 0.001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Std_Deviation_Mean',
        description: 'Liquid water cloud optical thickness: mean of daily log standard deviation',
        'gee:scale': 0.001,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Mean_Uncertainty',
        description: |||
          Liquid water cloud optical thickness: multi-day absolute
          uncertainty estimate derived from the daily absolute uncertainty
          estimate
        |||,
        'gee:scale': 0.01,
      },
      {
        name: 'Cloud_Optical_Thickness_Liquid_Log_Mean_Uncertainty',
        description: |||
          Liquid water cloud optical thickness: multi-day absolute
          log uncertainty estimate derived from the daily absolute log
          uncertainty estimate
        |||,
        'gee:scale': 0.001,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aerosol Optical Depth',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              3000.0,
            ],
            palette: [
              'ffffff',
              '1303ff',
              '01ff09',
              'ff2f00',
            ],
            bands: [
              'Aerosol_Optical_Depth_Land_Ocean_Mean_Mean',
            ],
          },
        },
      },
    ],
    Aerosol_Optical_Depth_Land_Ocean_Mean_Mean: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_Ocean_Std_Deviation_Mean: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_QA_Mean_Mean_470: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Aerosol_Optical_Depth_Land_QA_Std_Deviation_Mean_470: {
      minimum: -100.0,
      maximum: 5000.0,
      'gee:estimated_range': false,
    },
    Cirrus_Fraction_SWIR_FMean: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Cirrus_Fraction_SWIR_FStd: {
      minimum: 0.0,
      maximum: 10000.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Mean_Mean: {
      minimum: 0.0,
      maximum: 4176.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Std_Deviation_Mean: {
      minimum: 0.0,
      maximum: 4176.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Mean_Uncertainty: {
      minimum: 0.0,
      maximum: 2000.0,
      'gee:estimated_range': false,
    },
    Cloud_Optical_Thickness_Liquid_Log_Mean_Uncertainty: {
      minimum: 0.0,
      maximum: 4477.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/MODIS/MOD08_M3.061',
  'sci:citation': |||
    Platnick, S., M. King, P. Hubanks, 2015. MODIS Atmosphere L3 Monthly
    Product. NASA MODIS Adaptive Processing System, Goddard Space Flight
    Center, [doi:10.5067/MODIS/MOD08_M3.061](https://doi.org/10.5067/MODIS/MOD08_M3.061)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See
    [NASA\'s Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
