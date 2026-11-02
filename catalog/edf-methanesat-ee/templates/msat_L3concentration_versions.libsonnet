local ee_const = import 'earthengine_const.libsonnet';

[
  {
    ['1.0.0' + ee_const.version_deprecated_suffix] : 'projects/edf-methanesat-ee/assets/public-preview/L3concentration',
  },
  {
    '1.0.0': 'projects/edf-methanesat-ee/assets/msat/L3concentration',
  }
]