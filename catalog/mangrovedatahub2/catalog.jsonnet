local id = 'mangrovedatahub2';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'mangrovedatahub2/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Continuous Global Mangrove Dynamics',
  description: importstr 'description.md',

  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://www.themangrovelab.com/',
    contactDisplay: 'The Mangrove Lab',
    contactLink: 'mailto:zzhang58@tulane.edu',
  },

  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_mangrovedatahub2_assets_CGMD-AFCC30', base_url),
    ee.link.child_collection('projects_mangrovedatahub2_assets_CGMD-Extent30', base_url),
  ],
}