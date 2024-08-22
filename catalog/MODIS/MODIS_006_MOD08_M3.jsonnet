local id = 'MODIS/006/MOD08_M3';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD08_M3_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD08_M3.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD08_M3.006 Terra Aerosol Cloud Water Vapor Ozone Monthly Global Product 1Deg CMG [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    MOD08_M3 V6 is an atmosphere global product that contains
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
      href: 'https://doi.org/10.5067/MODIS/MOD08_M3.006',
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
    ee.producer_provider('NASA LAADS DAAC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/MODIS/MOD08_M3.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-03-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD08_M3.006',
  'sci:citation': |||
    Platnick, S., M. King, P. Hubanks, 2015. MODIS Atmosphere L3 Monthly
    Product. NASA MODIS Adaptive Processing System, Goddard Space Flight
    Center, [doi:10.5067/MODIS/MOD08_M3.006](https://doi.org/10.5067/MODIS/MOD08_M3.006)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA\'s
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
