local id = 'MODIS/006/MOD11A2';
local latest_id = 'MODIS/061/MOD11A2';
local successor_id = 'MODIS/061/MOD11A2';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/MODIS_006_MOD11A2.libsonnet';

local license = spdx.proprietary;

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
  title: 'MOD11A2.006 Terra Land Surface Temperature and Emissivity 8-Day Global 1km [deprecated]',
  deprecated: true,
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD11A2 V6 product provides an average 8-day land
    surface temperature (LST)  in a 1200 x 1200 kilometer grid.  Each
    pixel value in MOD11A2 is a simple average of all the corresponding
    MOD11A1 LST pixels collected within that 8 day period.  The 8 day
    compositing period was chosen because twice that period is the
    exact ground track repeat period of the Terra and Aqua platforms.
    In this product, along with both the day- and night-time surface
    temperature bands and their quality indicator (QC) layers, are
    also MODIS bands 31 and 32 and eight observation layers.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/118/MOD11_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/119/MOD11_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD11A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD11A2.006',
    },
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(successor_id, successor_url),
  ],
  keywords: [
    '8_day',
    'emissivity',
    'global',
    'lst',
    'mod11a2',
    'modis',
    'nasa',
    'surface_temperature',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD11A2.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001212-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD11A2.006',
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
