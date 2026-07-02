local id = 'projects/global-pasture-watch/assets/gld-1km/v1/horse-headcount-faostat_m';
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
  title: 'GPW Annual horse headcount FAOSTAT-adjusted v' + version,
  version: version,

  description: |||
    This dataset provides global horse headcount from 2000 to 2022 at 1-km spatial resolution.
  ||| + livestock_md,

  'gee:categories': ['agriculture'],

  keywords: [
    'livestock',
    'headcount',
    'faostat',
    'gpw',
    'global',
  ],

  providers: [
    ee.producer_provider('Land and Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2022-12-31T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'headcount',
        description: 'Headcount (horse)',
        gsd: 1000
      }
    ],

    headcount: {
      minimum: 0,
      maximum: 10,
      'gee:estimated_range': true
    },

    'gee:visualizations': [
      {
        display_name: 'Headcount (horse)',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [10],
            palette: [
              'd7d7d7',
              'ffffd4',
              'fed98e',
              'fe9929',
              'd95f0e',
              '993404'
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
  'sci:doi': '10.5281/zenodo.20396303',
  'sci:citation': |||
     Parente, L., Ehrmann, S., Hengl, T., Fritz, S., Bonannella, C., et al. (2026). Global Pasture Watch - Annual livestock headcount layers for cattle, goats, sheep, horses, and buffaloes at 1-km 2000–2022 (FAOSTAT-adjusted) (Version v1) [Data set]. Zenodo. [doi:https://doi.org/10.5281/zenodo.20396303](https://doi.org/10.5281/zenodo.20396303)
  ||| + livestock_md,
  'sci:publications': [
    {
      citation: |||
        Parente, L., Ehrmann, S., Hengl, T., Fritz, S., Bonannella, C., et al. (2026).
        Global distribution of cattle, horses, goats, sheep and buffaloes at 1 km resolution for 2000–2022 based on subnational census data and spatiotemporal machine learning. PeerJ.
        [doi: 10.7717/peerj.21494](https://dx.doi.org/10.7717/peerj.21494)
      |||,
      doi: '10.7717/peerj.21494',
    }
  ],
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
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
