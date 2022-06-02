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
  title: id,
  description: |||
    Basemaps for Tropical Forest Monitoring from
    [Planet](https://www.planet.com/) and
    [Norway's International Climate and Forest Initiative (NICFI)](https://www.norad.no/en/front/thematic-areas/climate-change-and-environment/norways-international-climate-and-forest-initiative-nicfi/).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_africa', base_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_americas', base_url),
    ee.link.child_collection('projects_planet-nicfi_assets_basemaps_asia', base_url),
  ],
}
