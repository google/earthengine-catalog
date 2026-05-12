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
  title: 'MapBiomas',
  description: |||
    [MapBiomas](https://mapbiomas.org) is a collaborative network of NGOs,
    universities, and technology companies focused on developing annual land
    use and land cover maps for Brazil and other countries using satellite
    imagery and machine learning.

    The project promotes transparency, scientific rigor, and open access to
    environmental data for monitoring land use changes over time.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_brazil_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_bolivia_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_ecuador_lulc_v1', base_url),
  ],
}
