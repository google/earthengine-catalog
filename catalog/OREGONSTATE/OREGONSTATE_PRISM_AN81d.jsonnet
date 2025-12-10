local prism = import 'prism.libsonnet';
local successor_id = 'OREGONSTATE/PRISM/ANd';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

prism {
  id: 'OREGONSTATE/PRISM/AN81d',
  title: 'PRISM Daily Spatial Climate Dataset AN81d [deprecated]',
  'gee:status': 'deprecated',
  version: '81',
  links+: [
    ee.link.successor(
      successor_id,
      ee_const.catalog_base + 'OREGONSTATE/OREGONSTATE_PRISM_ANd.json'
    ),
  ],
}
