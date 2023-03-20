local id = 'MODIS/006/MYD17A2H';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD17A2H.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD17A2H.006: Aqua Gross Primary Productivity 8-Day Global 500M 500m',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD17A2H V6 Gross Primary Productivity (GPP) product
    is a cumulative 8-day composite with a 500m resolution. The product
    is based on the radiation-use efficiency concept and can be potentially
    used as inputs to data models to calculate terrestrial energy,
    carbon, water cycle processes, and biogeochemistry of vegetation.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/495/MOD17_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/95/MOD17_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MYD17A2H)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD17A2H.006',
    },
  ],
  keywords: [
    '8_day',
    'aqua',
    'global',
    'gpp',
    'modis',
    'myd17a2',
    'nasa',
    'photosynthesis',
    'productivity',
    'psn',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD17A2H.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C203669706-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD17A2H.006',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
