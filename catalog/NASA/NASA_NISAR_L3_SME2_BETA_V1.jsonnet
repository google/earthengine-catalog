local nisar_sme2 = import 'templates/NASA_NISAR_SME2.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/NASA_NISAR_SME2_versions.libsonnet';

local id = 'NASA/NISAR/L3_SME2_BETA_V1';
local version_config = versions('NASA', version_table, id);

nisar_sme2.nasa_nisar_sme2_collection({
  id: id,
  version_config: version_config,
  status: 'deprecated',
  doi: '10.5067/NIL3SME2-B1',
  provider_id: 'C2850265000-ASF',
  start_date: '2025-10-17T00:00:00Z',
  end_date: '2026-01-20T23:59:59Z',
})

