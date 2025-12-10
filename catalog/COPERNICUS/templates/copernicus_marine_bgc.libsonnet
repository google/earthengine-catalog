local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
local subdir = 'COPERNICUS';

local ALL_DEPTHS = [
  0.49402538, 1.5413754, 2.6456685, 3.8194947, 5.0782237, 6.4406142,
  7.9295602, 9.5729971, 11.405003, 13.467138, 15.810073, 18.49556,
  21.598816, 25.211409, 29.444729, 34.434155, 40.344051, 47.373688,
  55.76429, 65.807274, 77.853851, 92.326073, 109.72928, 130.66599,
  155.85072, 186.12556, 222.47517, 266.04025, 318.12744, 380.21301,
  453.93774, 541.08893, 643.56683, 763.33307, 902.33929, 1062.4397,
  1245.2911, 1452.251, 1684.2844, 1941.8934, 2225.0779, 2533.3362,
  2865.7026, 3220.8203, 3597.032, 3992.4839, 4405.2241, 4833.2905,
  5274.7842, 5727.9165
];

local description = |||
  The Operational Mercator Ocean biogeochemical global ocean analysis and
  forecast system at 1/4 degree is providing 10 days of 3D global ocean
  forecasts updated weekly. The time series is aggregated in time, in order
  to reach a two full year's time series sliding window. This product
  includes daily and monthly mean files of biogeochemical parameters
  (chlorophyll, nitrate, phosphate, silicate, dissolved oxygen, dissolved
  iron, primary production, phytoplankton, zooplankton, PH, and surface
  partial pressure of carbon dioxide) over the global ocean. The global
  ocean output files are displayed with a 1/4 degree horizontal resolution
  with regular longitude/latitude equirectangular projection.
|||;

local citation = |||
  E.U. Copernicus Marine Service Information.
  [https://doi.org/10.48670/moi-00015](https://doi.org/10.48670/moi-00015)
|||;

local terms_of_use = |||
  The data is provided free of charge by the Copernicus Marine Service.
  Users must acknowledge the Copernicus Marine Service as the data source
  when using the data. More details on the terms of use can be found on
  the [Copernicus Marine Service website](https://marine.copernicus.eu/user-corner/service-commitments-and-licence).
|||;

// Function to generate bands for a given base band name and list of depths
local gen_bands(base_name, description, gee_units, depths) = [
  {
    name: base_name + '_depth%d' % index,
    description: description + ' (depth %d, %.4fm)' % [index, depths[index - 1]],
    'gee:units': gee_units,
  }
  for index in std.range(1, std.length(depths))
];

// Function to generate summaries for a given base band name and list of depths
local gen_summaries(base_name, min_val, max_val, depths) = {
  ['%s_depth%d' % [base_name, index]]: {
    minimum: min_val,
    maximum: max_val,
    'gee:estimated_range': true,
  }
  for index in std.range(1, std.length(depths))
};

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci
  ],
  license: license.id,
  keywords: [
    'copernicus',
    'marine',
    'ocean',
  ],
  extent: ee.extent_global('2022-01-01T00:00:00Z', null),
  interval: {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  description: description,
  citation: citation,
  terms_of_use: terms_of_use,
  links(id):: ee.standardLinks(subdir, id),
  providers(id):: [
    ee.producer_provider('Copernicus', 'https://marine.copernicus.eu/'),
    ee.host_provider(ee_const.ee_catalog_url + std.strReplace(id, '/', '_')),
  ],
  gen_bands: gen_bands,
  gen_summaries: gen_summaries,
  ALL_DEPTHS: ALL_DEPTHS,
}
