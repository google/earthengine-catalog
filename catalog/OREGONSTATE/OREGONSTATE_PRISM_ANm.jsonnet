local prism = import 'prism.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

prism {
  params+:: { period: 'monthly' },
  id: 'OREGONSTATE/PRISM/ANm',
  version: '81_91',
  title: 'PRISM Monthly Spatial Climate Dataset ANm',
  description: super.description_intro +
              |||
                This collection contains both AN81 and AN91
                data, as indicated by the 'dataset_type' property.
              ||| +
                super.description_outro,
  extent: ee.extent(-125.0, 24.0, -66.0, 50.0, '1895-01-01T00:00:00Z', null),
  summaries+: {
    'gee:schema': super['gee:schema'] + [
      {
        name: 'PRISM_DATASET_RELEASE_NUMBER',
        description: |||
          An integer (1-7) per band, indicating how many times
          a grid has been re-modeled within the 6-month window. Grids are
          considered stable after 6 months. This property is not present on
          AN81 data.
        |||,
        type: ee_const.var_type.int_list,
      },
      {
        name: 'dataset_type',
        description: 'Dataset type: "AN81" or "AN91"',
        type: ee_const.var_type.string,
      },
    ],
  },
}
