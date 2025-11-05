local daily = import 'prism_daily.libsonnet';
local successor_id = 'OREGONSTATE/PRISM/ANd';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

daily {
  id: 'OREGONSTATE/PRISM/AN81d',
  title: 'PRISM Daily Spatial Climate Dataset AN81d [deprecated]',
  description: daily.description_intro + daily.description_outro,
  'gee:status': 'deprecated',
  version: '81',
  links+: [
    ee.link.successor(
      successor_id,
      ee_const.catalog_base + 'OREGONSTATE/OREGONSTATE_PRISM_ANd.json'
    ),
  ],
}
