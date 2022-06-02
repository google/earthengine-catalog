local id = 'MODIS/006/MYD08_M3';
local successor_id = 'MODIS/061/MYD08_M3';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD08_M3.libsonnet';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD08_M3.006 Aqua Aerosol Cloud Water Vapor Ozone Monthly Global Product 1Deg CMG [deprecated]',
  version: 'V006',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    MYD08_M3 V6 is an atmosphere global product that contains
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
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.5067/MODIS/MYD08_M3.006',
    },
  ],
  keywords: [
    'aqua',
    'atmosphere',
    'geophysical',
    'global',
    'modis',
    'monthly',
    'myd08',
    'myd08_m3',
    'nasa',
    'temperature',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LAADS DAAC at NASA Goddard Space Flight Center', 'https://doi.org/10.5067/MODIS/MYD08_M3.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD08_M3.006',
  'sci:citation': |||
    Platnick, S., M. King, P. Hubanks, 2015. MODIS Atmosphere L3 Monthly
    Product. NASA MODIS Adaptive Processing System, Goddard Space Flight
    Center, [doi:10.5067/MODIS/MYD08_M3.006](https://doi.org/10.5067/MODIS/MYD08_M3.006)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA\'s
    Earth Science Data & Information Policy](https://science.nasa.gov/earth-science/earth-science-data/data-information-policy)
    for additional information.
  |||,
}
