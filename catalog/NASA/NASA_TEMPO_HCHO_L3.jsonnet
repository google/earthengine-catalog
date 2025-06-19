local tempo_hcho_l3_raw = import 'templates/NASA_TEMPO_HCHO.libsonnet';

local qa_or_raw_link = |||

  * A version of this dataset with QA filters applied is available as [NASA/TEMPO/HCHO_L3_QA](NASA_TEMPO_HCHO_L3_QA)
|||;
tempo_hcho_l3_raw.nasa_tempo_hcho_collection({
  id: 'NASA/TEMPO/HCHO_L3',
  qa_title: '',
  qa_description: '',
  quality_flag_desc: '',
  effective_cloud_fraction_desc: '',
  solar_zenith_angle_desc: '',
  qa_or_raw_link: qa_or_raw_link,
})
