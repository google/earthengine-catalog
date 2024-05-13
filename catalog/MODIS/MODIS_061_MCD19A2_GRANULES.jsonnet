local id = 'MODIS/061/MCD19A2_GRANULES';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD19A2_GRANULES_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MCD19A2_GRANULES.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD19A2.061: Terra & Aqua MAIAC Land Aerosol Optical Depth Daily 1km',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD19A2 V6.1 data product is a MODIS Terra and Aqua combined Multi-angle
    Implementation of Atmospheric Correction (MAIAC) Land Aerosol Optical Depth
    (AOD) gridded Level 2 product produced daily at 1 km resolution. For more
    information see the [MAIAC user guide](https://lpdaac.usgs.gov/documents/1500/MCD19_User_Guide_V61.pdf).

    NOTE: This product has been released with the caveat that the reprocessing
    for the full mission is expected to continue through summer 2023.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD19A2.061',
    },
  ] + version_config.version_links,
  keywords: [
    'aerosol',
    'aod',
    'aqua',
    'daily',
    'global',
    'maiac',
    'mcd19a2',
    'modis',
    'nasa',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD19A2.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000505-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD19A2.061',
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
