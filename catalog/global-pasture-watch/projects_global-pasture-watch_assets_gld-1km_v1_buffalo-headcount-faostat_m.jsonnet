local id = 'projects/global-pasture-watch/assets/gld-1km/v1/buffalo-headcount-faostat_m';
local subdir = 'global-pasture-watch';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;
local livestock_md = importstr 'gld-1km_v1_faostat-headcount.md';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;


{
  id: id,
  title: 'GPW Buffalo Headcount FAOSTAT-adjusted v' + version,
  version: version,

  description: |||
    This dataset provides annual FAOSTAT-adjusted buffalo headcount layers
    from the Global Pasture Watch livestock density product at 1-km spatial resolution.

    TODO: Add technical description, citation/provenance, and the 4-step CRS/area workflow.
  ||| + livestock_md,

  'gee:categories': ['agriculture'],

  keywords: [
    'livestock',
    'buffalo',
    'headcount',
    'faostat',
    'gpw',
    'global',
  ],

  providers: [
    ee.producer_provider('Land and Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', null),
  summaries: {
    'eo:bands': [
      {
        name: 'headcount',
        description: 'Estimated buffalo headcount per pixel.',
        gsd: 1000
      }
    ],

    headcount: {
      minimum: 0,
      maximum: 500,
      'gee:estimated_range': true
    },

    'gee:visualizations': [
      {
        display_name: 'Buffalo headcount',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [500],
            palette: [
              'ffffcc',
              'c2e699',
              '78c679',
              '31a354',
              '006837',
            ],
            bands: ['headcount'],
          }
        },
      }
    ],
    'gee:schema': [
      {
        name: 'version',
        description: 'Product version',
        type: ee_const.var_type.int
      },
    ],
  },

  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'sci:doi': 'TODO',
  'sci:citation': |||
    TODO: Add citation for the FAOSTAT-adjusted GPW livestock headcount layers.
  ||| + livestock_md,
  'sci:publications': [
  ],
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
