// catalog.jsonnet
local id = 'mapbiomas-public';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + id + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    This catalog contains land use and land cover datasets provided by the [MapBiomas Project](https://mapbiomas.org).
    These datasets include annual land cover classifications derived from satellite imagery, covering Brazil and other countries.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_brazil_lulc_v1', base_url),
    // Você pode adicionar links para outras coleções MapBiomas aqui, como MapBiomas Chaco, MapBiomas Desmatamento, etc.
  ],
}
