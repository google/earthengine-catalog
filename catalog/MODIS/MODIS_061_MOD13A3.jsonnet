local id = 'MODIS/061/MOD13A3';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD13A3.libsonnet';

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
  title: 'MOD13A3.061 Vegetation Indices Monthly L3 Global 1 km SIN Grid',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD13A3 V6.1 product data is provided monthly at 1 kilometer (km)
    spatial resolution. In generating this monthly product, the algorithm
    ingests all the MOD13A2 products that overlap the month and employs a
    weighted temporal average.

    Vegetation indices are used for global monitoring of vegetation conditions
    and are used in products displaying land cover and land cover changes. These
    data may be used as input for modeling global biogeochemical and hydrologic
    processes as well as global and regional climate. Additional applications
    include characterizing land surface biophysical properties and processes,
    such as primary production and land cover conversion.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/621/MOD13_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/104/MOD13_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MOD13A3)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD13A3.061',
    },
  ],
  keywords: [
    'evi',
    'global',
    'modis',
    'monthly',
    'nasa',
    'ndvi',
    'terra',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD13A3.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001238-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD13A3.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
