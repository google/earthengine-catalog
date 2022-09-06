local id = 'LARSE/GEDI/GEDI02_A_002';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi = import 'gedi.libsonnet';

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
  title: 'GEDI L2A Vector Canopy Top Height (Version 2)',
  version: '2',
  'gee:type': ee_const.gee_type.table_collection,
  description: gedi.description + |||
    The GEDI L2A Monthly raster data can be found in the image collection
    [LARSE/GEDI/GEDI02_A_002_MONTHLY](LARSE_GEDI_GEDI02_A_002_MONTHLY).

    The GEDI L4B biomass data can be found in the image
    [LARSE/GEDI/GEDI04_B_002](LARSE_GEDI_GEDI04_B_002).

    Please see [User Guide](https://lpdaac.usgs.gov/documents/986/GEDI02_UserGuide_V2.pdf)
    for more information.
  |||,
  license: gedi.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi.keywords,
  // Because Google is not changing vector data, the first parameter should be empty.
  providers: gedi.providers('', self_ee_catalog_url),
  extent: {
    spatial: gedi.extent.spatial,
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
      for band in (gedi.regular_bands + [gedi.shot_number] + gedi.rh_bands)
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
  'sci:doi': '10.5067/GEDI/GEDI02_A.002',
  'sci:citation': |||
    GEDI L2A Elevation and Height Metrics Data Global Footprint Level - GEDI02_A
    Dubayah, R., M. Hofton, J. Blair, J. Armston, H. Tang, S. Luthcke. GEDI L2A
    Elevation and Height Metrics Data Global Footprint Level V002. 2021,
    distributed by NASA EOSDIS Land Processes DAAC. Accessed YYYY-MM-DD.
  |||,
  'gee:terms_of_use': gedi.terms_of_use,
}
