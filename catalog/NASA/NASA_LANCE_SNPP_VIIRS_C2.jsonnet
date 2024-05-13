local id = 'NASA/LANCE/SNPP_VIIRS/C2';
local subdir = 'NASA';

local viirs_firms = import 'NASA_LANCE_VIIRS.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VNP14IMGTDL_NRT Daily Raster: VIIRS (S-NPP) Band 375m Active Fire',
  version: '6',
  'gee:type': ee_const.gee_type.image_collection,
  description: 'Suomi NPP ' + viirs_firms.description,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: viirs_firms.keywords,
  providers: [
    ee.producer_provider('NASA / LANCE / SNPP_VIIRS', 'https://www.earthdata.nasa.gov/learn/find-data/near-real-time/firms/vnp14imgtdlnrt'),
    ee.host_provider(self_ee_catalog_url)
  ],
  'gee:provider_ids': [
    'C1942970257-LANCEMODIS',
  ],
  extent: ee.extent_global('2023-09-03T00:00:00Z', null),
  summaries: {
    gsd: viirs_firms.gsd,
    'eo:bands': viirs_firms.bands,
    'gee:visualizations': viirs_firms.visualizations,
    Bright_ti4: viirs_firms.Bright_ti4,
    Bright_ti5: viirs_firms.Bright_ti5,
    confidence: viirs_firms.confidence,
    line_number: viirs_firms.line_number,
  },
  'sci:citation': |||
    NRT VIIRS 375 m Active Fire product VNP14IMGT distributed from NASA FIRMS.
    Available on-line https://earthdata.nasa.gov/firms.
    [doi:10.5067/FIRMS/VIIRS/VNP14IMGT_NRT.002](https://doi.org/10.5067/FIRMS/VIIRS/VNP14IMGT_NRT.002)
  |||,
  'gee:interval': viirs_firms.interval,
  'gee:terms_of_use': viirs_firms.terms_of_use,
}
