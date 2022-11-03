local id = 'NASA/GSFC';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'NASA/GSFC/';
local parent_url = ee_const.catalog_base + 'NASA/catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'GSFC',
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('NASA_GSFC_MERRA_aer_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_flx_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_lnd_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_rad_2', base_url),
    ee.link.child_collection('NASA_GSFC_MERRA_slv_2', base_url),
  ],
}
