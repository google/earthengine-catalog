local id = 'Finland';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'Finland/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Orthophotos of Finland.
    An orthophoto is an aerial photograph or satellite imagery geometrically
    corrected such that the scale is uniform.
    
    This catalog is dedicated to Finland Orthophotos from a variety of sources.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('Finland_MAVI_VV_50cm', base_url),
    ee.link.child_collection('Finland_SMK_V_50cm', base_url),
    ee.link.child_collection('Finland_SMK_VV_50cm', base_url),
  ],
}
