local tempo_no2_l3_raw = import 'templates/NASA_TEMPO_NO2.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NASA_TEMPO_NO2_versions.libsonnet';

local id = 'NASA/TEMPO/NO2_L3_V4';
local version_config = versions('NASA', version_table, id);
local qa_or_raw_link = |||

  * A version of this dataset with QA filters applied is available as [NASA/TEMPO/NO2_L3_V4_QA](NASA_TEMPO_NO2_L3_V4_QA)
|||;

local extra_bands = [
  {
    name: 'pbl_height',
    description: 'Planetary boundary layer height',
    'gee:units': units.meter,
  },
];

tempo_no2_l3_raw.nasa_tempo_no2_collection({
  id: id,
  version_config: version_config,
  status: 'beta',
  doi: '10.5067/IS-40e/TEMPO/NO2_L3.004',
  provider_id: 'C3685896708-LARC_CLOUD',
  qa_title: '',
  qa_description: '',
  quality_flag_desc: '',
  effective_cloud_fraction_desc: '',
  solar_zenith_angle_desc: '',
  qa_or_raw_link: qa_or_raw_link,
  extra_bands: extra_bands,
})
