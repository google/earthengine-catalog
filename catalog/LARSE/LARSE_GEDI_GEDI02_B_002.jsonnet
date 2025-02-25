local id = 'LARSE/GEDI/GEDI02_B_002';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l2a = import 'gedi_l2a.libsonnet';
local gedi_l2b = import 'gedi_l2b.libsonnet';
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
  title: 'GEDI L2B Vector Canopy Cover Vertical Profile Metrics (Version 2)',
  version: '2',
  'gee:type': ee_const.gee_type.table_collection,
  description: gedi_l2b.description +
  |||
    The original GEDI02_B product is a table of points with a spatial resolution
    (average footprint) of 25 meters.

    Please see [User Guide](https://lpdaac.usgs.gov/documents/986/GEDI02_UserGuide_V2.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['forest-biomass'],
  keywords: gedi_l2a.keywords,
  // Because Google is not changing vector data, the first parameter should be empty.
  providers: gedi_l2a.providers('', self_ee_catalog_url),
  extent: {
    spatial: gedi_l2a.extent.spatial,
    // TODO(b/229788379): figure out what to do about the end date of table collections.
    temporal: { interval: [['2019-03-25T00:00:00Z', '2023-01-01T00:00:00Z']] },
  },
  summaries: {
    // GEDI tables are rasterized as bands in the MONTHLY collection, so the
    // table properties here and the raster bands in the MONTHLY collection
    // are the same.
    'gee:schema': [
      // TODO(b/225852120): Add gee:units field after adding support for units in table schema.
      { name: band.name, description: band.description, type: band.type }
      for band in (
          gedi_l2b.regular_bands +
          gedi_l2b.cover_bands +
          gedi_l2b.pai_bands +
          gedi_l2b.pavd_bands
       )
    ],
    'gee:visualizations': [{
      display_name: 'preview',
      table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: 12.6,
        lat: 51.01,
        zoom: 12,
      },
    }],
  },
  'sci:doi': '10.5067/GEDI/GEDI02_B.002',
  'sci:citation': gedi_l2b.citation,
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
