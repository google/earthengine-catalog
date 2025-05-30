local tempo_no2_l3_raw = import 'templates/NASA_TEMPO_NO2.libsonnet';

local qa_or_raw_link = |||

  * NO2 QA catalog link: [NASA/TEMPO/NO2_L3_QA](NASA_TEMPO_NO2_L3_QA)
|||;
tempo_no2_l3_raw.nasa_tempo_no2_collection({
  id: 'NASA/TEMPO/NO2_L3',
  qa_title: '',
  qa_description: '',
  quality_flag_desc: '',
  effective_cloud_fraction_desc: '',
  solar_zenith_angle_desc: '',
  qa_or_raw_link: qa_or_raw_link,
})
