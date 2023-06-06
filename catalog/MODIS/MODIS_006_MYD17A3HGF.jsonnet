local id = 'MODIS/006/MYD17A3HGF';
local latest_id = 'MODIS/061/MYD17A3HGF';
local successor_id = 'MODIS/061/MYD17A3HGF';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD17A3HGF.libsonnet';

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
  title: 'MYD17A3HGF.006: Aqua Net Primary Production  Gap-Filled Yearly Global 500m [deprecated]',
  deprecated: true,
  version: '6',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Version 6 MODIS data products. Users are advised to transition to the
    improved Version 6.1.

    The MYD17A3HGF V6 product provides information about
    annual Net Primary Productivity (NPP) at 500m pixel resolution.
     Annual NPP is derived from the sum of all 8-day Net Photosynthesis
    (PSN) products (MYD17A2H) from the given year.  The PSN value
    is the difference of the Gross Primary Productivity (GPP) and the
    Maintenance Respiration (MR) (GPP-MR).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD17A3HGF.006',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(successor_id, successor_url),
  ],
  keywords: [
    'aqua',
    'global',
    'gpp',
    'modis',
    'myd17a3',
    'myd17a3gf',
    'nasa',
    'npp',
    'photosynthesis',
    'productivity',
    'psn',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD17A3HGF.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1631984536-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD17A3HGF.006',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
