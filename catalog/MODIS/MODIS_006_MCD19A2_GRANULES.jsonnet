local id = 'MODIS/006/MCD19A2_GRANULES';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD19A2_GRANULES.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD19A2.006: Terra & Aqua MAIAC Land Aerosol Optical Depth Daily 1km',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD19A2 V6 data product is a MODIS Terra and Aqua combined Multi-angle
    Implementation of Atmospheric Correction (MAIAC) Land Aerosol Optical Depth (AOD) gridded
    Level 2 product produced daily at 1 km resolution. For more information
    see the [MAIAC user guide](https://lpdaac.usgs.gov/documents/110/MCD19_User_Guide_V6.pdf).

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/110/MCD19_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/111/MCD19_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MCD19A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD19A2.006',
    },
  ],
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
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD19A2.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000505-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-26T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD19A2.006',
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
