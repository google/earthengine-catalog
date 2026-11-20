local id = 'LARSE/GEDI/GEDI02_A_003';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l2a = import 'gedi_l2a.libsonnet';
local gedi = importstr 'gedi_v3.md';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L2A Vector Canopy Top Height (Version 3)',
  version: '3',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.folder,
  description: gedi_l2a.description_v3 + |||

    Please see the [User
    Guide](https://lpdaac.usgs.gov/documents/2442/GEDI02_User_Guide_V3.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['forest-biomass'],
  keywords: gedi_l2a.keywords,
  // Google does not modify source vector observations, so omit prefix.
  providers: gedi_l2a.providers(
    '',
    self_ee_catalog_url,
    'https://doi.org/10.5067/GEDI/GEDI02_A.003'
  ),
  extent: {
    spatial: gedi_l2a.extent.spatial,
    temporal: { interval: [['2019-04-04T00:00:00Z', null]] },
  },
  summaries: {
    'gee:schema': [
      { name: band.name, description: band.description, type: band.type }
      for band in (
        gedi_l2a.regular_bands_v3 + [gedi_l2a.shot_number] + gedi_l2a.rh_bands
      )
    ],
    'gee:visualizations': [
      {
        display_name: 'preview',
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
        lookat: {
          lon: -64.88,
          lat: -31.77,
          zoom: 13,
        },
      },
    ],
  },
  'sci:doi': '10.5067/GEDI/GEDI02_A.003',
  'sci:citation': gedi_l2a.citation_v3,
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
