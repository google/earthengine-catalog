local id = 'MODIS/061/MOD17A3HGF';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD17A3HGF_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD17A3HGF.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD17A3HGF.061: Terra Net Primary Production Gap-Filled Yearly Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD17A3HGF V6.1 product provides information about annual Gross and Net
    Primary Productivity (GPP and NPP) at 500m pixel resolution. Annual NPP is
    derived from the sum of all 8-day Net Photosynthesis(PSN) products
    (MOD17A2H) from the given year.  The PSN value is the difference of the
    Gross Primary Productivity (GPP) and the Maintenance Respiration (MR)
    (GPP-MR).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD17A3HGF.061',
    },
  ] + version_config.version_links,
  keywords: [
    'global',
    'gpp',
    'nasa',
    'npp',
    'photosynthesis',
    'productivity',
    'psn',
    'terra',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD17A3HGF.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1648641919-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD17A3HGF.061',
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
