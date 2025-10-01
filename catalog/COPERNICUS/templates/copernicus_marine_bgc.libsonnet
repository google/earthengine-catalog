local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
local subdir = 'COPERNICUS';

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
  with regular longitude/latitude equirectangular projection. 50 vertical
  levels are ranging from 0 to 5700 meters.
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

// Function to generate bands for a given base band name and number of depths
local gen_bands(base_name, description, gee_units, num_depths) = [
  {
    name: base_name + '_depth%d' % depth_index,
    description: description + ' (depth %d)' % depth_index,
    'gee:units': gee_units,
  }
  for depth_index in std.range(1, num_depths)
];

// Function to generate summaries for a given base band name and number of depths
local gen_summaries(base_name, min_val, max_val, num_depths) = {
  ['%s_depth%d' % [base_name, depth_index]]: {
    minimum: min_val,
    maximum: max_val,
    'gee:estimated_range': true,
  }
  for depth_index in std.range(1, num_depths)
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
}
