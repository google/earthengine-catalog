local nisar_sme2 = import 'templates/NASA_NISAR_SME2.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NASA_NISAR_SME2_versions.libsonnet';

local id = 'NASA/NISAR/L3_SME2_PROVISIONAL_V1';
local version_config = versions('NASA', version_table, id);

nisar_sme2.nasa_nisar_sme2_collection({
  id: id,
  version_config: version_config,
  doi: '10.5067/NIL3SME2-P1',
  provider_id: 'C2854344945-ASF',
  start_date: '2025-11-24T00:00:00Z',
})

