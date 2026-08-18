local id = 'AIRBUS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'AIRBUS/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Datasets from [Airbus](https://www.airbus.com/en/products-services/space/earth-observation/optical-and-radar-satellites).
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_MS_NC_V1', base_url),
    ee.link.child_collection('AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_MS_V1', base_url),
    ee.link.child_collection('AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_PAN_V1', base_url),
    ee.link.child_collection('AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_PMS_NC_V1', base_url),
  ],
}
