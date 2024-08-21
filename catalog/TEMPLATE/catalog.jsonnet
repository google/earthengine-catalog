// Change the id to be the subdirectory that contains this file.
local id = 'TEMPLATE';
local subdir = id;

local description = importstr 'description.md';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + subdir + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: description,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    // TODO(google): Enable link when changing gee:status
    // ee.link.child_collection('TEMPLATE_IMAGE_V2_1', base_url),
  ],
}
