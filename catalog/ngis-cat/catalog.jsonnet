local id = 'ngis-cat';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'ngis-cat/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    The National Intertidal Digital Elevation Model (NIDEM) is a
    continental-scale elevation dataset for Australia exposed intertidal zone.
    This product provides the first three-dimensional representation of
    Australia intertidal sandy beaches and shores, tidal flats and rocky shores
    and reefs at 25 m spatial resolution, addressing a key gap between the
    availability of sub-tidal bathymetry and terrestrial elevation data.
    Intertidal environments support important ecological habitats (e.g. sandy
    beaches and shores, tidal flats and rocky shores and reefs), and provide
    many valuable benefits such as storm surge protection, carbon storage and
    natural resources for recreational and commercial use.  Intertidal zones are
    faced with increasing threats from coastal erosion, land reclamation
    (e.g. port construction), and sea level rise.  Accurate elevation data
    describing the height and shape of the coastline is needed to help predict
    when and where these threats will have the greatest impact.  However, this
    data is expensive and challenging to map across the entire intertidal zone
    of a continent the size of Australia.

    For more information, please see the
    [DEA Intertidal Elevation](https://cmi.ga.gov.au/data-products/dea/325/dea-intertidal-elevation-landsat#basics)
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    // TODO(schwehr): Example when the dataset is ready.
    // ee.link.child_collection('projects_ngis-cat_assets_DEA_NIDEM', base_url),
  ],
}
