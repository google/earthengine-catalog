local ee_const = import 'earthengine_const.libsonnet';
{
  probabilistic: [
    { ['1.0.0' + ee_const.version_deprecated_suffix]: 'projects/gcp-public-data-weathernext/assets/126478713_1_0' },
    { '1.0.0': 'projects/gcp-public-data-weathernext/assets/weathernext_2_0_0' },
  ],
  deterministic: [
    { ['1.0.0' + ee_const.version_deprecated_suffix]: 'projects/gcp-public-data-weathernext/assets/59572747_4_0' },
    { '1.0.0': 'projects/gcp-public-data-weathernext/assets/weathernext_2_0_0_mean' },
  ],
}
