local id = 'pml_evapotranspiration';
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
  title: 'Large Scale Hydrology Lab',
  description: |||
    The Large Scale Hydrology Lab specializes in advancing global and
    regional water cycle research by synthesizing multi-source Earth
    observations with process-based modeling. We are widely recognized
    for the Penman-Monteith-Leuning (PML) model and its high-accuracy,
    long-term evapotranspiration (ET) and gross primary productivity
    (GPP) products.

    By integrating remote sensing, machine learning, and surface process
    modeling, our goal is to provide essential data infrastructure for
    monitoring water-carbon coupling and understanding climate change
    impacts at a global scale.
  |||,
  'gee:publisher': {
    type: 'PUBLISHER',
    link: 'https://zhang-hydrolab.github.io/',
    contactDisplay: 'Large Scale Hydrology Lab',
    contactLink: 'mailto:zhangyq@igsnrr.ac.cn'
  },
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('projects_pml_evapotranspiration_PML_OUTPUT_PML_V22a', base_url),
    ee.link.child_collection('projects_pml_evapotranspiration_PML_OUTPUT_PML_V22a_VIIRS', base_url),
  ],
}
