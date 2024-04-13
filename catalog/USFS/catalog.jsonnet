local id = 'USFS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USFS/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('USFS_GTAC_LCMS_v2020-5', base_url),
    ee.link.child_collection('USFS_GTAC_LCMS_v2020-6', base_url),
    ee.link.child_collection('USFS_GTAC_LCMS_v2021-7', base_url),
    ee.link.child_collection('USFS_GTAC_LCMS_v2022-8', base_url),
    ee.link.child_collection('USFS_GTAC_LCMS_v2023-9', base_url),
    ee.link.child_collection('USFS_GTAC_MTBS_burned_area_boundaries_v1', base_url),
    ee.link.child_collection('USFS_GTAC_MTBS_annual_burn_severity_mosaics_v1', base_url),
    ee.link.child_collection('USFS_GTAC_TreeMap_v2016', base_url),
  ],
}
