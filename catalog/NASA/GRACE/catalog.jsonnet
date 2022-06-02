local id = 'NASA/GRACE';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/GRACE/';
local parent_url = ee_const.catalog_base + 'NASA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GRACE',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_LAND', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_MASCON', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_MASCON_CRI', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_OCEAN', base_url),
    ee.link.child_collection('NASA_GRACE_MASS_GRIDS_OCEAN_EOFR', base_url),
  ],
}
