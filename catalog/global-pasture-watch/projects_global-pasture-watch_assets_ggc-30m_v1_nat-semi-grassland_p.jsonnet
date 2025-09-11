local id = 'projects/global-pasture-watch/assets/ggc-30m/v1/nat-semi-grassland_p';
local subdir = 'global-pasture-watch';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local ggc30m_v1 = importstr 'ggc-30m_v1.md';
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'GPW Annual Probabilities of Natural/Semi-natural Grasslands v' + version,
  version: version,
  description: |||
    This dataset provides global annual probability maps of natural/semi-natural
    grassland from 2000 to 2022 at 30-m spatial resolution. 
  ||| + ggc30m_v1,
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'pasture',
    'rangeland',
    'vegetation',
    'land',
    'landcover',
    'landuse',
    'global',
  ],

  providers: [
    ee.producer_provider('Land and Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2023-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'probability',
        description: 'Natural/Semi-natural grassland probability value derived through Random Forest.',
        gsd: 30
      }
    ],
    probability: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Natural/Semi-natural grassland probability value',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: [
              'f7f1e5',
              'af8260',
              '803d3b',
              '322c2b'
            ],
            bands: ['probability'],
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

  'sci:doi': '10.5281/zenodo.13890401',
  'sci:citation': |||
    Parente, L., Sloat, L., Mesquita, V., et al. (2024) 
    Global Pasture Watch - Annual grassland class and extent 
    maps at 30-m spatial resolution (2000—2022) (Version v1) 
    [Data set]. Zenodo
    [doi:https://doi.org/10.5281/zenodo.13890401](https://doi.org/10.5281/zenodo.13890401)
  |||,
  'sci:publications': [
    {
      citation: |||
        Parente, L., Sloat, L., Mesquita, V., et al. (2024).
        Annual 30-m maps of global grassland class and extent (2000–2022) 
        based on spatiotemporal Machine Learning, Scientific Data.
        [doi: http://doi.org/10.1038/s41597-024-04139-6](http://doi.org/10.1038/s41597-024-04139-6)
      |||,
      doi: '10.1038/s41597-024-04139-6',
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
