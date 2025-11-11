local prism = import 'prism.libsonnet';
local successor_id = 'OREGONSTATE/PRISM/ANm';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

prism {
  params+:: { period: 'monthly' },
  id: 'OREGONSTATE/PRISM/AN81m',
  title: 'PRISM Monthly Spatial Climate Dataset AN81m [deprecated]',
  'gee:status': 'deprecated',
  version: '81',
  links+: [
    ee.link.successor(
      successor_id,
      ee_const.catalog_base + 'OREGONSTATE/OREGONSTATE_PRISM_ANm.json'
    ),
  ],
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0, '1895-01-01T00:00:00Z', null),
}
