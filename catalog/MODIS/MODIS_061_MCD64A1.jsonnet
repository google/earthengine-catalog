local id = 'MODIS/061/MCD64A1';
local latest_id = 'MODIS/061/MCD64A1';
local predecessor_id = 'MODIS/006/MCD64A1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/MODIS_006_MCD64A1.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = latest_basename + '.json';
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;
local latest_url = catalog_subdir_url + latest_filename;
local predecessor_url = catalog_subdir_url + predecessor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD64A1.061 MODIS Burned Area Monthly Global 500m',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Terra and Aqua combined MCD64A1 Version 6 Burned Area data product is
    a monthly, global gridded 500m product containing per-pixel burned-area
    and quality information. The MCD64A1 burned-area mapping approach employs
    500m MODIS Surface Reflectance imagery coupled with 1km MODIS active
    fire observations. The algorithm uses a burn sensitive vegetation index (VI)
    to create dynamic thresholds that are applied to the composite data.
    The VI is derived from MODIS shortwave infrared atmospherically corrected
    surface reflectance bands 5 and 7 with a measure of temporal texture.
    The algorithm identifies the date of burn for the 500m grid cells within
    each individual MODIS tile. The date is encoded in a single data layer as
    the ordinal day of the calendar year on which the burn occurred, with
    values assigned to unburned land pixels and additional special values
    reserved for missing data and water grid cells.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1006/MCD64_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/115/MCD64_ATBD_V6.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MCD64A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD64A1.061',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    'burn',
    'fire',
    'geophysical',
    'global',
    'mcd64a1',
    'modis',
    'monthly',
    'nasa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD64A1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1620913371-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-11-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD64A1.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
