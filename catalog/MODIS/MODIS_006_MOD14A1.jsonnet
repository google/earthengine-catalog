local id = 'MODIS/006/MOD14A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD14A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local template = import 'templates/MODIS_006_MOD14A1.libsonnet';

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
  title: 'MOD14A1.006: Terra Thermal Anomalies & Fire Daily Global 1km [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD14A1 V6 dataset provides daily fire mask composites
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

    * [User's Guide](https://lpdaac.usgs.gov/documents/88/MOD14_User_Guide_v6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/87/MOD14_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD14A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD14A1.006',
    },
  ] + version_config.version_links,
  keywords: [
    'daily',
    'fire',
    'global',
    'mod14a1',
    'modis',
    'nasa',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD14A1.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001242-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', '2023-02-17T00:00:00Z'),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD14A1.006',
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
