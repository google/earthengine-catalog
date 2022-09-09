local id = 'LARSE/GEDI/GEDI02_B_002_INDEX';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local gedi = importstr 'gedi.md';
local gedi_l2a = import 'gedi_l2a.libsonnet';
local gedi_l2b = import 'gedi_l2b.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L2B table index',
  version: '2',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This is a feature collection created from the geometries of L2B tables in
    [LARSE/GEDI/GEDI02_B_002](LARSE_GEDI_GEDI02_B_002). Each feature is
    a polygon footprint of a source table with its asset id and start/end
    timestamps.

    Please see [User Guide](https://lpdaac.usgs.gov/documents/986/GEDI02_UserGuide_V2.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi_l2a.keywords,
  providers: gedi_l2a.providers('Indexing: Google and ', self_ee_catalog_url),
  extent: {
    spatial: gedi_l2a.extent.spatial,
    // TODO(b/229788379): figure out what to do about the end date of table
    // collections.
    temporal: { interval: [['2019-03-25T00:00:00Z', '2023-01-01T00:00:00Z']] },
  },
  summaries: {
    'gee:schema': [
      {
        name: 'table_id',
        description: 'GEDI L2B table collection Ids',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_start',
        description: 'GEDI L2B table start time in the ISO 8601 format',
        type: ee_const.var_type.string,
      },
      {
        name: 'time_end',
        description: 'GEDI L2B table end time in the ISO 8601 format',
        type: ee_const.var_type.string,
      }
    ],
    'gee:visualizations': [
      {
        display_name: 'preview',
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
        lookat: {
          lat: 29,
          lon: 37,
          zoom: 3,
        },
      },
    ],
  },
  'sci:citation': gedi_l2b.citation,
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
