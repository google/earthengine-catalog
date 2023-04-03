local id = 'MODIS/006/MODOCGA';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MODOCGA.libsonnet';

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
  title: 'MODOCGA.006 Terra Ocean Reflectance Daily Global 1km',
  version: 'V006',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODOCGA V6 ocean reflectance product consists of
    1 kilometer reflectance data from Terra MODIS bands 8-16. The product
    is referred to as ocean reflectance, because bands 8-16 are used
    primarily to produce ocean products, but this is not an ocean product
    as the tiles produced are land tiles.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/306/MOD09_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/305/MOD09_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MODOCGA)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MODOCGA.006',
    },
  ],
  keywords: [
    'daily',
    'global',
    'modis',
    'modocga',
    'nasa',
    'ocean',
    'reflectance',
    'sr',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MODOCGA.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C203669731-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MODOCGA.006',
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
