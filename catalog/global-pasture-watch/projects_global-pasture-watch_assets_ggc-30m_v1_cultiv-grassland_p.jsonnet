local id = 'projects/global-pasture-watch/assets/ggc-30m/v1/cultiv-grassland_p';
local subdir = 'global-pasture-watch';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'GPW Annual Probabilities of Cultivated Grasslands v' + version,
  version: version,
  description: |||
    This dataset provides global annual probabilitiy maps of cultivated
    grassland from 2000 to 2022 at 30-m spatial resolution. Produced by Land &#38;
    Carbon Lab Global Pasture Watch initiative, the mapped grassland extent
    includes any land cover type, which contains at least 30% of dry or wet
    low vegetation, dominated by grasses and forbs (less than 3 meters) 
    and a:
    - maximum of 50% tree canopy cover (greater than 5 meters),
    - maximum of 70% of other woody vegetation (scrubs and open shrubland), and
    - maximum of 50% active cropland cover in mosaic landscapes of cropland
     &#38; other vegetation.
    
    The grassland extent is classified into two classes:
    - Cultivated grassland: Areas where grasses and other forage plants have
    been intentionally planted and managed, as well as areas of native 
    grassland-type vegetation where they clearly exhibit active and
    heavy management for specific human-directed uses, such as directed
    grazing of livestock.
    - Natural/Semi-natural grassland: Relatively undisturbed native
    grasslands/short-height vegetation, such as steppes and tundra, 
    as well as areas that have experienced varying degrees of human 
    activity in the past, which may contain a mix of native and 
    introduced species due to historical land use and natural processes. 
    In general, they exhibit natural-looking patterns of varied vegetation 
    and clearly ordered hydrological relationships throughout the landscape.
    
    The implemeted methdology considered [GLAD Landsat ARD-2 image 
    archive](https://glad.umd.edu/ard), accompanied by climatic, 
    landform and proximity covariates, spatiotemporal machine learning 
    (per-class Random Forest) and over 2.3 million reference samples 
    (visually interpreted in Very High Resolution imagery). 
    Custom probability thresholds (based on five-fold spatial 
    cross-validation) were used to derive dominant class maps 
    with balanced precision and recall values, 0.64 and 0.75 
    for cultivated and natural/semi-natural grassland, respectively.
    For more information see [Parente et. al, 2024](http://doi.org/10.1038/s41597-024-04139-6),
    [Zenodo](https://zenodo.org/records/13890401) and 
    [https://github.com/wri/global-pasture-watch](https://github.com/wri/global-pasture-watch)
  |||,
  keywords: [
    'land',
    'landcover',
    'landuse',
    'global',
    'vegetation'
  ],

  providers: [
    ee.producer_provider('Land &#38; Carbon Lab Global Pasture Watch', 'https://landcarbonlab.org/data/global-grassland-and-livestock-monitoring'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2023-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'probability',
        description: 'Cultivated grassland probability value derived through Random Forest.',
        gsd: 30
      }
    ],
    probability: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Cultivated grassland probability value',
        lookat: {lon: -55.50, lat: -12.20, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: [
              'f5f5f5',
              'fdaf27',
              'ae7947',
              '3a2200'
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

  'sci:doi': '10.1038/s41597-024-04139-6',
  'sci:citation': |||
    Parente, L., Sloat, L., Mesquita, V., et al. (2024).
    Annual 30-m maps of global grassland class and extent (2000–2022) 
    based on spatiotemporal Machine Learning, Scientific Data.
    [doi:http://doi.org/10.1038/s41597-024-04139-6](http://doi.org/10.1038/s41597-024-04139-6),
  |||,
  'sci:publications': [
    {
      citation: |||
        Parente, L., Sloat, L., Mesquita, V., et al. (2024) 
        Global Pasture Watch - Annual grassland class and extent 
        maps at 30-m spatial resolution (2000—2022) (Version v1) 
        [Data set]. Zenodo
        [doi:https://doi.org/10.5281/zenodo.13890401](https://doi.org/10.5281/zenodo.13890401),
      |||,
      doi: '10.5281/zenodo.13890401',
    }
  ],
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'incomplete',
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
