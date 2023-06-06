local id = 'MODIS/061/MCD43A3';
local predecessor_id = 'MODIS/006/MCD43A3';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD43A3.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local predecessor_basename = std.strReplace(predecessor_id, '/', '_');
local predecessor_filename = predecessor_basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
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
  title: 'MCD43A3.061 MODIS Albedo Daily 500m',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43A3 V6.1 Albedo Model dataset is a daily 16-day
    product. It provides both directional hemispherical reflectance
    (black sky albedo) and bihemispherical reflectance (white sky albedo)
    for each of the MODIS surface reflectance bands (band 1 through
    band 7) as well as 3 broad spectrum bands (visible, near infrared,
    and shortwave).  Each 500m/pixel daily image is generated using
    16 days of data, centered on the given day.  A quality band is
    also provided for each of the 10 albedo bands.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/97/MCD43_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MCD43A3)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43A3.061',
    },
    ee.link.predecessor(predecessor_id, predecessor_url)
  ],
  keywords: [
    'albedo',
    'black_sky',
    'daily',
    'global',
    'modis',
    'nasa',
    'usgs',
    'white_sky',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43A3.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2278860820-LPCLOUD',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD43A3.061',
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
