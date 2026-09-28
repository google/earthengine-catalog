local id = 'radar-wur';
local subdir = id;

local description = importstr 'description.md';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + subdir + '/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Wageningen University and Research - Radar Remote Sensing',
  description: description,

  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://www.wur.nl/en/research/products-services/radd-forest-disturbance-alert',
    contactDisplay: 'johannes.reiche@wur.nl',
    contactLink: 'mailto:johannes.reiche@wur.nl',
  },

  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection(
      'projects_radar-wur_assets_raddalert_v1',
      base_url
    ),
  ],
}


// MORE DATASETS CAN BE ADDED as child_collection, I think...