local id = 'MODIS/061/MOD21C2';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD21C1.libsonnet';

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
  title: 'MOD21C2.061 Terra Land Surface Temperature and 3-Band Emissivity 8-Day L3 Global 0.05 Deg CMG',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD21C2 dataset is an 8-day composite LST product that uses an algorithm
    based on a simple averaging method. The algorithm calculates the average
    from all the cloud free MOD21A1D and MOD21A1N daily acquisitions from the
    8-day period. Unlike the MOD21A1 data sets where the daytime and nighttime
    acquisitions are separate products, the MOD21A2 contains both daytime and
    nighttime acquisitions. The LST, Quality Control (QC), view zenith angle,
    and viewing time have separate day and night bands, while the values for the
    MODIS emissivity bands 29, 31, and 32 are the average of both the nighttime
    and daytime acquisitions.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1398/MOD21_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1399/MOD21_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MOD21C2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD21C2.061',
    },
  ],
  keywords: [
    'emissivity',
    'global',
    'lst',
    'nasa',
    'surface_temperature',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD21C2.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1646692033-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    'eo:bands' : template.bands + [
      {
        name: 'Clear_sky_days',
        description: 'Bitmap of Clear Sky Days (1 = clear, LSB = 1st day)',
      },
      {
        name: 'Clear_sky_nights',
        description: 'Bitmap of Clear Sky Nights (1 = clear, LSB = 1st day)',
      },
    ],
    platform: [
      'Terra',
    ],
    Clear_sky_days: {
      minimum: 0.0,
      maximum: 2147483647.0,
      'gee:estimated_range': false,
    },
    Clear_sky_nights: {
      minimum: 0.0,
      maximum: 2147483647.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.5067/MODIS/MOD21C2.061',
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
