local id = 'LARSE/GEDI/GRIDDEDVEG_002/COUNTS/V1/12KM';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_vegetation = import 'gedi_vegetation.libsonnet';

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
  title: 'Gridded GEDI Vegetation Structure Metrics and Biomass Density with COUNTS metrics, 12KM pixel size',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  // TODO(simonf): figure out why require() in example scripts doesn't work
  // in tests
  'gee:user_uploaded': true,
  description: gedi_vegetation.description + 'This dataset uses the pixel size of 12KM with counts metrics.',
  license: gedi_vegetation.license,
  links: ee.standardLinks(subdir, id),
  keywords: gedi_vegetation.keywords,
  providers: gedi_vegetation.providers(
    'Rasterization: Google and ', self_ee_catalog_url),
  extent: gedi_vegetation.extent,
  summaries: {
    gsd: [
      12000.0,
    ],
    'eo:bands': gedi_vegetation.counts_bands,
    'gee:visualizations': [
      {
        display_name: 'shots_count',
        lookat: {
          lat: -46.46,
          lon: -11,
          zoom: 5,
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
              'shots_count',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': gedi_vegetation.citation,
  'gee:terms_of_use': gedi_vegetation.terms_of_use,
}
