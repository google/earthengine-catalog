local ee_const = import 'earthengine_const.libsonnet';
[
  { [ee_const.version_unknown + ee_const.version_deprecated_suffix]: { id: 'FORMA/FORMA_500m', subdir: 'FORMA' } },
  { [ee_const.version_unknown]: { id: 'WRI/GFW/FORMA/alerts', subdir: 'WRI' } },
]
