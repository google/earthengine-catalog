local prism = import 'prism.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';

prism {
  id: 'OREGONSTATE/PRISM/ANd',
  version: '81_91',
  title: 'PRISM Daily Spatial Climate Dataset ANd',
  description: prism.description_intro +
              |||
                This collection contains both AN81 and AN91
                data, indicated by the 'dataset_type' property.
              ||| +
                prism.description_outro,
  summaries+: {
    'gee:schema': super['gee:schema'] + [
      {
        name: 'PRISM_DATASET_RELEASE_NUMBER',
        description: |||
          An integer (1-8) per band, indicating how many times
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
