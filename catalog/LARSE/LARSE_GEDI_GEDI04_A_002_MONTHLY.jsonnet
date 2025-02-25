local id = 'LARSE/GEDI/GEDI04_A_002_MONTHLY';
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
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L4A Raster Aboveground Biomass Density, Version 2.1',
  version: '2.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: gedi_l4a.description + |||
    The dataset LARSE/GEDI/GEDI04_A_002_MONTHLY is a raster version
    of the original GEDI04_A product. The raster images are organized as monthly
    composites of individual orbits in the corresponding month.

    See [User Guide](https://daac.ornl.gov/GEDI/guides/GEDI_L4A_AGB_Density_V2_1.html)
    for more information.
  ||| + gedi,
  license: gedi_l4a.license,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['forest-biomass'],
  keywords: gedi_l4a.keywords,
  providers: gedi_l4a.providers(
    'Rasterization: Google and ', self_ee_catalog_url),
  extent: gedi_l4a.extent,
  summaries: {
    gsd: [
      25.0,
    ],
    // Not including shot_number, as we ingest it as a string table property,
    // which cannot be rasterized.
    'eo:bands': gedi_l4a.regular_bands + gedi_l4a.group_bands,
    'gee:visualizations': [
      {
        display_name: 'Relative height',
        lookat: {
          lat: 2,
          lon: 48.5,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              60.0,
            ],
            palette: [
              'darkred',
              'red',
              'orange',
              'green',
              'darkgreen',
            ],
            bands: [
              'agbd',
            ],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': gedi_l4a.terms_of_use,
}