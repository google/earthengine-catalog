local id = 'LARSE/GEDI/GEDI02_B_002_MONTHLY';
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
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GEDI L2B Raster Canopy Cover Vertical Profile Metrics (Version 2)',
  version: '2',
  'gee:type': ee_const.gee_type.image_collection,
  description: gedi_l2b.description + |||

    The dataset LARSE/GEDI/GEDI02_B_002_MONTHLY is a raster version
    of the original GEDI02_B product. The raster images are organized as monthly
    composites of individual orbits in the corresponding month. Only root-level
    cover, pai and pavd values and their associated quality flags and metadata
    are preserved as raster bands. Each GEDI02_B_002 raster has 109 bands.

    See [User Guide](https://lpdaac.usgs.gov/documents/986/GEDI02_UserGuide_V2.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['forest-biomass'],
  keywords: gedi_l2a.keywords,
  providers: gedi_l2a.providers(
    'Rasterization: Google and ', self_ee_catalog_url),
  extent: gedi_l2a.extent,
  summaries: {
    gsd: [
      25.0,
    ],
    // Not including shot_number, as we ingest it as a string table property,
    // which cannot be rasterized.
    'eo:bands': gedi_l2b.regular_bands +
      gedi_l2b.cover_bands + gedi_l2b.pai_bands + gedi_l2b.pavd_bands,
    'gee:visualizations': [
      {
        display_name: 'Solar Elevation',
        lookat: {
          lat: 12,
          lon: 15,
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
              'solar_elevation',
            ],
          },
        },
      },
    ],
   algorithmrun_flag:{
      minimum:0,
      maximum:1,
      'gee:estimated_range':false
   },
   beam:{
      minimum:0,
      maximum:11,
      'gee:estimated_range':false
   },
   cover:{
      minimum:0,
      maximum:1,
      'gee:estimated_range':false
   },
   degrade_flag: {
      minimum: 0,
      maximum: 99,
      'gee:estimated_range': false,
   },
   l2b_quality_flag:{
      minimum:0,
      maximum:1,
      'gee:estimated_range':false
   },
   local_beam_azimuth:{
      minimum:-180,
      maximum:180,
      'gee:estimated_range':false
   },
   local_beam_elevation:{
      minimum:1.39,
      maximum:1.57,
      'gee:estimated_range':false
   },
   pgap_theta:{
      minimum:0,
      maximum:1,
      'gee:estimated_range':false
   },
   selected_l2a_algorithm:{
      minimum:1,
      maximum:6,
      'gee:estimated_range':false
   },
   selected_rg_algorithm:{
      minimum:0,
      maximum:99,
      'gee:estimated_range':false
   },
   sensitivity:{
      minimum:0,
      maximum:1,
      'gee:estimated_range':false
   },
   solar_azimuth:{
      minimum:-180,
      maximum:180,
      'gee:estimated_range':false
   },
   solar_elevation:{
      minimum:-90,
      maximum:90,
      'gee:estimated_range':false
   },
  } + {
    ['cover_z' + step]: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    }
    for step in std.range(0, 30)
  },
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
