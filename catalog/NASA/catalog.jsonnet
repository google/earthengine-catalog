local id = 'NASA';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/';
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
    ee.link.child_catalog('ASTER_GED', base_url),
    ee.link.child_catalog('FLDAS', base_url),
    ee.link.child_catalog('GEOS-CF', base_url),
    ee.link.child_catalog('GIMMS', base_url),
    ee.link.child_catalog('GLDAS', base_url),
    ee.link.child_catalog('GPM_L3', base_url),
    ee.link.child_catalog('GRACE', base_url),
    ee.link.child_catalog('GSFC', base_url),
    ee.link.child_catalog('JPL', base_url),
    ee.link.child_catalog('MEASURES', base_url),
    ee.link.child_catalog('NASADEM_HGT', base_url),
    ee.link.child_catalog('NLDAS', base_url),
    ee.link.child_catalog('OCEANDATA', base_url),
    ee.link.child_catalog('ORNL', base_url),
    ee.link.child_collection('NASA_NEX-DCP30', base_url),
    ee.link.child_collection('NASA_NEX-DCP30_ENSEMBLE_STATS', base_url),
    ee.link.child_collection('NASA_NEX-GDDP', base_url),
  ],
}
