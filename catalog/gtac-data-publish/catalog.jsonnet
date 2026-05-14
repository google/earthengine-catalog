local id = 'gtac-data-publish';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'gtac-data-publish/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'USDA Forest Service',
  description: |||
    The USDA Forest Service provides a suite of national datasets to monitor
    the health and diversity of forests, grasslands, and surrounding
    landscapes across the United States.

    These datasets offer a wide range of applications for federal, state, and
    private partners to support the sustainable use and management of natural
    resources and land uses to meet diverse public needs.
  |||,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://www.fs.usda.gov/',
    contactDisplay: 'USDA Forest Service',
    contactLink: ''
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_gtac-data-publish_assets_LCMS_Product_Version_2025-11', base_url),
  ],
}
