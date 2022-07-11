local id = 'MODIS/006/MYD09GA';
local latest_id = 'MODIS/061/MYD09GA';
local successor_id = 'MODIS/061/MYD09GA';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD09GA.libsonnet';

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = latest_basename + '.json';
local successor_filename = successor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local latest_url = catalog_subdir_url + latest_filename;
local successor_url = catalog_subdir_url + successor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD09GA.006 Aqua Surface Reflectance Daily Global 1km and 500m [deprecated]',
  deprecated: true,
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Surface Reflectance products provide an estimate
    of the surface spectral reflectance as it would be measured at
    ground level in the absence of atmospheric scattering or absorption.
    Low-level data are corrected for atmospheric gases and aerosols.
    MYD09GA version 6 provides bands 1-7 in a daily gridded L2G product
    in the sinusoidal projection, including 500m reflectance values
    and 1km observation and geolocation statistics.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/306/MOD09_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/305/MOD09_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MYD09GA)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD09GA.006',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(successor_id, successor_url),
  ],
  keywords: [
    'aqua',
    'daily',
    'global',
    'modis',
    'myd09ga',
    'nasa',
    'sr',
    'surface_reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD09GA.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C193529459-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD09GA.006',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
