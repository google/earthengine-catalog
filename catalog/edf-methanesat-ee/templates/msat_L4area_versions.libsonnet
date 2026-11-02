local ee_const = import 'earthengine_const.libsonnet';

[
  {
    ['1.0.0' + ee_const.version_deprecated_suffix]: 'projects/edf-methanesat-ee/assets/public-preview/L4area',
  },
  {
    ['2.0.0' + ee_const.version_deprecated_suffix]: 'projects/edf-methanesat-ee/assets/public-preview/L4area_v2',
  },
  {
    '1.0.0': 'projects/edf-methanesat-ee/assets/msat/L4area',
  }
]