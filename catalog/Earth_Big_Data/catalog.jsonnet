local id = 'Earth_Big_Data';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'Earth_Big_Data/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    The Earth Big Data catalog contains datasets that are spatial
    representations of multi-seasonal, global C-band Synthetic Aperture
    Radar (SAR) interferometric repeat-pass coherence and backscatter
    signatures.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_BACKSCATTER', base_url),
    ee.link.child_collection('Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_COHERENCE', base_url),
    ee.link.child_collection('Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_DECAY_MODEL_PARAMETERS', base_url),
    ee.link.child_collection('Earth_Big_Data_GLOBAL_SEASONAL_S1_V2019_INCIDENCE_LAYOVER_SHADOW', base_url),
  ],
}
