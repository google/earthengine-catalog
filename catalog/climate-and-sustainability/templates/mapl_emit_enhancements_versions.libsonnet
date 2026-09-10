local ee_const = import 'earthengine_const.libsonnet';

[
  {
    ['1.0' + ee_const.version_deprecated_suffix]: {
      id: 'projects/nature-trace/assets/ghg/emit/mapl_emit_enhancements_v1_0',
      subdir: 'nature-trace',
    },
  },
  {
    '1.0': {
      id: 'projects/climate-and-sustainability/assets/ghg/emit/mapl_emit_enhancements_v1_0',
      subdir: 'climate-and-sustainability',
    },
  },
]
