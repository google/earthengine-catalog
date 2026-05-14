local id = 'planet-nicfi';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'planet-nicfi/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: 'Planet',
  description: |||
    [Planet](https://www.planet.com/) provides daily satellite data that helps
    businesses, governments, researchers, and journalists understand the
    physical world and take action.

    Through [Norway's International Climate and Forest Initiative (NICFI)](https://www.norad.no/en/front/thematic-areas/climate-change-and-environment/norways-international-climate-and-forest-initiative-nicfi/),
    users can now access Planet’s high-resolution, analysis-ready mosaics of
    the world’s tropics in order to help reduce and reverse the loss of
    tropical forests, combat climate change, conserve biodiversity, and
    facilitate sustainable development for non commercial uses.
  |||,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://planet.com/nicfi',
    contactDisplay: 'support@planet.com',
    contactLink: ''
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_africa', base_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_americas', base_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_asia', base_url),
  ],
}
