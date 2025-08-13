local id = 'projects/global-pasture-watch/assets/ggc-30m/v1/cultiv-grassland_p';
local subdir = 'global-pasture-watch';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local ugpp30m_v1 = importstr 'ugpp-30m_v1.md';
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'GPW Annual uncalibrated Gross Primary Productivity (uGPP) v' + version,
  version: version,
  description: |||
    This dataset provides global uncalibrated EO-based Gross Primary Productivity 
    from 2000 to 2024 at 30-m spatial resolution. 
  ||| + ugpp30m_v1,
  'gee:categories': ['plant-productivity'],
  keywords: [
    'global',
    'vegetation',
    'ecosystems',
    'land',
    'landcover',
    'landuse'
  ],

  providers: [
    ee.producer_provider('Land and Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2025-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'gc_m2',
        description: 'Grams of carbon per square meter per year (gC/m²/year)',
        gsd: 30
      }
    ],
    gc_m2: {minimum: 0, maximum: 4000, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'GPP value',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [4000],
            palette: [
              'faccfa',
              'f19d6b',
              '828232',
              '226061',
              '011959',
            ],
            bands: ['gc_m2'],
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
    Isik, M. S., Mesquita, V., Parente, L., & Consoli, D. (2025). 
    Global Pasture Watch - Source Code of the Global Uncalibrated EO-based GPP and 
    Grassland GPP Maps at 30m. Zenodo.
    [Source code]. Zenodo
    [doi:https://doi.org/10.5281/zenodo.15675358](https://doi.org/10.5281/zenodo.15675358)
  |||,
  'sci:publications': [
    {
      citation: |||
        Isik MS, Parente L, Consoli D, et al. (2025). 
        Light use efficiency (LUE) based bimonthly gross primary 
        productivity (GPP) for global grasslands at 30 m spatial 
        resolution (2000–2022), PeerJ.
        [doi: https://doi.org/10.7717/peerj.19774](https://doi.org/10.7717/peerj.19774)
      |||,
      doi: '10.7717/peerj.19774',
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
