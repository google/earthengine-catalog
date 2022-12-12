local id = 'GOOGLE';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'GOOGLE/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets from [Google](https://research.google/).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('GOOGLE_DYNAMICWORLD_V1', base_url),
    // TODO(gorelick): Add this back when we're ready to make it public.
    // ee.link.child_collection('GOOGLE_GLOBAL_CCDC_V1', base_url),
    ee.link.child_collection('GOOGLE_Research_open-buildings_v1_polygons', base_url),
    ee.link.child_collection('GOOGLE_Research_open-buildings_v2_polygons', base_url),
  ],
}
