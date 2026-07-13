local tempo_no2_l3_raw = import 'templates/NASA_TEMPO_NO2.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NASA_TEMPO_NO2_versions.libsonnet';
local id = 'NASA/TEMPO/NO2_L3';
local version_config = versions('NASA', version_table, id);

local qa_or_raw_link = |||

  * A version of this dataset with QA filters applied is available as [NASA/TEMPO/NO2_L3_QA](NASA_TEMPO_NO2_L3_QA)
|||;
tempo_no2_l3_raw.nasa_tempo_no2_collection({
  id: id,
  version_config: version_config,
  status: 'deprecated',
  doi: '10.5067/IS-40e/TEMPO/NO2_L3.003',
  provider_id: 'C2930763263-LARC_CLOUD',
  qa_title: '',
  qa_description: '',
  quality_flag_desc: '',
  effective_cloud_fraction_desc: '',
  solar_zenith_angle_desc: '',
  qa_or_raw_link: qa_or_raw_link,
})
