local id = 'projects/global-pasture-watch/assets/gsvh-30m/v1/short-veg-height_m';
local subdir = 'global-pasture-watch';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local svh30m_v1 = importstr 'svh-30m_v1.md';
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'GPW Annual short vegetation height v' + version,
  version: version,
  'gee:status': 'beta',
  description: |||
    This dataset provides global median vegetation height
    from 2000 at 30-m spatial resolution. 
  ||| + svh30m_v1,
  'gee:categories': ['plant-productivity'],
  keywords: [
    'canopy',
    'vegetation',
    'land',
    'landcover',
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
        name: 'height',
        description: 'Median vegetation height',
        gsd: 30,
        'gee:scale': 0.1,
        'gee:units': units.meter
      }
    ],
    height: {minimum: 0, maximum: 10, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Median vegetation height',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [10],
            palette: [
              'fcffa4',
              'f98d0a',
              'bb3755',
              '57106e',
              '000004',
            ],
            bands: ['height'],
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
  'sci:doi': '10.5281/zenodo.15198654',
  'sci:citation': |||
    Parente, L., Hunter, M., Ho, Y., Bonannella, C. el al. (2025).
    Global Pasture Watch - Annual short vegetation height maps at
    30-m spatial resolution (2000—2022) (Version v1)
    [Data set]. Zenodo. [doi:https://doi.org/10.5281/zenodo.15198654](https://doi.org/10.5281/zenodo.15198654)
  |||,
  'sci:publications': [
    {
      citation: |||
        Hunter, M.O., Parente, L., Ho, Yf. et al. (2025)
        Global 30-m annual median vegetation height maps (2000—2022)
        based on ICESat-2 data and Machine Learning. Scientific Data 12, 1470.
        [doi: https://doi.org/10.1038/s41597-025-05739-6](https://doi.org/10.1038/s41597-025-05739-6)
      |||,
      doi: '10.1038/s41597-025-05739-6',
    }
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
