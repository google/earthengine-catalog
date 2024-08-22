local id = 'MODIS/006/MYD17A3HGF';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD17A3HGF_versions.libsonnet';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD17A3HGF.libsonnet';

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
  'gee:status': 'deprecated',
  version: version,
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
  ] + version_config.version_links,
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
    ee.host_provider(version_config.ee_catalog_url),
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
