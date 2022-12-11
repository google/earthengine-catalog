local id = 'LARSE/GEDI/GEDI04_A_002';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l4a = import 'gedi_l4a.libsonnet';
local gedi = importstr 'gedi.md';

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
  title: 'GEDI L4A Aboveground Biomass Density, Version 2.1',
  version: '2.1',
  'gee:type': ee_const.gee_type.table_collection,
  description: gedi_l4a.description + |||

    Please see [User Guide](https://daac.ornl.gov/GEDI/guides/GEDI_L4A_AGB_Density_V2_1.html)
    for more information.
  ||| + gedi,
  license: gedi_l4a.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi_l4a.keywords,
  // Because Google is not changing vector data, the first parameter should be empty.
  providers: gedi_l4a.providers('', self_ee_catalog_url),
  extent: {
    spatial: gedi_l4a.extent.spatial,
    // TODO(b/229788379): figure out what to do about the end date of table collections.
    temporal: { interval: [['2019-04-18T00:00:00Z', '2022-06-09T00:00:00Z']] },
  },
  summaries: {
    // GEDI tables are rasterized as bands in the MONTHLY collection, so the
    // table properties here and the raster bands in the MONTHLY collection
    // are the same.
    'gee:schema': [
      // TODO(b/225852120): Add gee:units field after adding support for units in table schema.
      { name: band.name, description: band.description, type: band.type }
      for band in (gedi_l4a.regular_bands + gedi_l4a.group_bands)
    ],
    'gee:visualizations': [{
      display_name: 'preview',
      table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: 1,
        lat: 1,
        zoom: 2,
      },
    }],
  },
  'sci:doi': '10.5067/GEDI/GEDI04_A.002',
  'sci:citation': gedi_l4a.citation,
  'gee:terms_of_use': gedi_l4a.terms_of_use,
}
