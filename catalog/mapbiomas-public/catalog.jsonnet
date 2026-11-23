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
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://mapbiomas.org',
    contactDisplay: 'contato@mapbiomas.org',
    contactLink: 'https://brasil.mapbiomas.org/contato/'
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_brazil_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_bolivia_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_ecuador_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_peru_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_venezuela_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_uruguay_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_chile_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_colombia_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_argentina_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_mexico_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_suriname_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_pampa_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_indonesia_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_paraguay_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_drc_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_amazon_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_atlantic_forest_lulc_v1', base_url),
    ee.link.child_collection('projects_mapbiomas-public_assets_chaco_lulc_v1', base_url),
  ],
}
