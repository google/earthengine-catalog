local id = 'MODIS/061/MYD14A1';
local latest_id = 'MODIS/061/MYD14A1';
local predecessor_id = 'MODIS/006/MYD14A1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/MODIS_006_MOD14A1.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = latest_basename + '.json';
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
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
  title: 'MYD14A1.061: Aqua Thermal Anomalies & Fire Daily Global 1km',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD14A1 V6.1 dataset provides daily fire mask composites
    at 1km resolution derived from the MODIS 4- and 11-micrometer radiances.
    The fire detection strategy is based on absolute detection of a
    fire (when the fire strength is sufficient to detect), and on detection
    relative to its background (to account for variability of the surface
    temperature and reflection by sunlight). The product distinguishes
    between fire, no fire and no observation. This information is used
    for monitoring the spatial and temporal distribution of fires in
    different ecosystems, detecting changes in fire distribution and
    identifying new fire frontiers, wild fires, and changes in the
    frequency of the fires  or their relative strength.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1005/MOD14_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/87/MOD14_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MYD14A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD14A1.061',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    'aqua',
    'daily',
    'fire',
    'global',
    'modis',
    'myd14a1',
    'nasa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD14A1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1621434288-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD14A1.061',
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
