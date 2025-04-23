local id = 'MODIS/006/MOD44W';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD44W.libsonnet';

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
  title: 'MOD44W.006 Terra Land Water Mask Derived From MODIS and SRTM Yearly Global 250m',
  version: '6',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD44W V6 land/water mask 250m product is derived using a
    decision tree classifier trained with MODIS data and validated with the
    MOD44W V5 product. A series of masks are applied to address known issues
    caused by terrain shadow, burn scars, cloudiness, or ice cover in oceans.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD44W.006',
    },
  ],
  'gee:categories': ['surface-ground-water'],
  keywords: [
    'geophysical',
    'mod44w',
    'modis',
    'nasa',
    'srtm',
    'usgs',
    'water_mask',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD44W.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Space Shuttle Endeavour',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD44W.006',
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
