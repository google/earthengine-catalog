local id = 'LARSE/GEDI/GEDI02_A_002_MONTHLY';
local subdir = 'LARSE';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local gedi_l2a = import 'gedi_l2a.libsonnet';
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
  title: 'GEDI L2A Raster Canopy Top Height (Version 2)',
  version: '2',
  'gee:type': ee_const.gee_type.image_collection,
  description: gedi_l2a.description + |||
    The dataset LARSE/GEDI/GEDI02_A_002_MONTHLY is a raster version
    of the original GEDI02_A product. The raster images are organized as monthly
    composites of individual orbits in the corresponding month. Only root-level
    RH values and their associated quality flags and metadata are preserved
    as raster bands. Each GEDI02_A_002 raster has 136 bands.

    See [User Guide](https://lpdaac.usgs.gov/documents/986/GEDI02_UserGuide_V2.pdf)
    for more information.
  ||| + gedi,
  license: gedi_l2a.license,
  links: ee.standardLinks(subdir, id),
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
    'eo:bands': gedi_l2a.regular_bands + gedi_l2a.rh_bands,
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
              'rh98',
            ],
          },
        },
      },
    ],
    beam: {
      minimum: 0,
      maximum: 12,
      'gee:estimated_range': false,
    },
    degrade_flag: {
      minimum: 0,
      maximum: 99,
      'gee:estimated_range': false,
    },
    elev_highestreturn: {
      minimum: -1000,
      maximum: 25000,
      'gee:estimated_range': false,
    },
    elev_lowestmode: {
      minimum: -1000,
      maximum: 25000,
      'gee:estimated_range': false,
    },
    elevation_bias_flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    energy_total: {
      minimum: -5000,
      maximum: 5000000,
      'gee:estimated_range': false,
    },
    landsat_water_persistence: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    lat_highestreturn: {
      minimum: -55,
      maximum: 55,
      'gee:estimated_range': false,
    },
    leaf_off_doy: {
      minimum: 1,
      maximum: 365,
      'gee:estimated_range': false,
    },
    leaf_off_flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    leaf_on_cycle: {
      minimum: 1,
      maximum: 2,
      'gee:estimated_range': false,
    },
    leaf_on_doy: {
      minimum: 1,
      maximum: 365,
      'gee:estimated_range': false,
    },
    lon_highestreturn: {
      minimum: -180,
      maximum: 180,
      'gee:estimated_range': false,
    },
    num_detectedmodes: {
      minimum: 0,
      maximum: 20,
      'gee:estimated_range': false,
    },
    pft_class: {
      minimum: 0,
      maximum: 11,
      'gee:estimated_range': false,
    },
    quality_flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    region_class: {
      minimum: 0,
      maximum: 7,
      'gee:estimated_range': false,
    },
    selected_algorithm: {
      minimum: 1,
      maximum: 6,
      'gee:estimated_range': false,
    },
    selected_mode: {
      minimum: 0,
      maximum: 20,
      'gee:estimated_range': false,
    },
    selected_mode_flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    sensitivity: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    surface_flag: {
      minimum: 0,
      maximum: 1,
      'gee:estimated_range': false,
    },
    urban_focal_window_size: {
      minimum: 3,
      maximum: 5,
      'gee:estimated_range': false,
    },
    urban_proportion: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
  } + {
    ['rh' + step]: {
      minimum: -213,
      maximum: 213,
      'gee:estimated_range': false,
    }
    for step in std.range(0, 100)
  },
  'gee:terms_of_use': gedi_l2a.terms_of_use,
}
