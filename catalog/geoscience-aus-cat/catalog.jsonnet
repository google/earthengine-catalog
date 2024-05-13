local id = 'geoscience-aus-cat';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'geoscience-aus-cat/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets for Australia from [Geoscience Australia](https://www.dea.ga.gov.au/). For more datasets and information, please see [GA products](https://www.dea.ga.gov.au/products).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection(
        'projects_geoscience-aus-cat_assets_NIDEM', base_url),
    ee.link.child_collection(
        'projects_geoscience-aus-cat_assets_ga_ls_landcover_class_cyear_2', base_url),
    ee.link.child_collection(
        'projects_geoscience-aus-cat_assets_ga_ls5t_nbart_gm_cyear_3', base_url),
    ee.link.child_collection(
        'projects_geoscience-aus-cat_assets_ga_ls7e_nbart_gm_cyear_3', base_url),
    ee.link.child_collection(
        'projects_geoscience-aus-cat_assets_ga_ls8c_nbart_gm_cyear_3', base_url),
    ee.link.child_collection(
       'projects_geoscience-aus-cat_assets_ga_ls_wo_fq_cyear_3', base_url),
  ],
}
