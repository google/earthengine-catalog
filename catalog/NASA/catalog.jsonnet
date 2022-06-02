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
    { rel: 'child', title: 'ASTER_GED', href: base_url + 'ASTER_GED/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'FLDAS', href: base_url + 'FLDAS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GEOS-CF', href: base_url + 'GEOS-CF/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GIMMS', href: base_url + 'GIMMS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GLDAS', href: base_url + 'GLDAS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GPM_L3', href: base_url + 'GPM_L3/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'GRACE', href: base_url + 'GRACE/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'JPL', href: base_url + 'JPL/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'MEASURES', href: base_url + 'MEASURES/catalog.json', type: ee_const.media_type.stac },
    // TODO: Uncomment when all assets are ingested
    // { rel: 'child', title: 'MERRA', href: base_url + 'MERRA/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NASADEM_HGT', href: base_url + 'NASADEM_HGT/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'NLDAS', href: base_url + 'NLDAS/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'OCEANDATA', href: base_url + 'OCEANDATA/catalog.json', type: ee_const.media_type.stac },
    { rel: 'child', title: 'ORNL', href: base_url + 'ORNL/catalog.json', type: ee_const.media_type.stac },
    ee.link.child_collection('NASA_NEX-DCP30', base_url),
    ee.link.child_collection('NASA_NEX-DCP30_ENSEMBLE_STATS', base_url),
    ee.link.child_collection('NASA_NEX-GDDP', base_url),
  ],
}
