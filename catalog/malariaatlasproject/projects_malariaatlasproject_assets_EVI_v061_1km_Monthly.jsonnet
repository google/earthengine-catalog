local id = 'projects/malariaatlasproject/assets/EVI_v061/1km/Monthly';
local subdir = 'malariaatlasproject';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'EVI: Malaria Atlas Project Gap-Filled Enhanced Vegetation Index (Monthly 1km)',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The underlying dataset for this Enhanced Vegetation Index (EVI)
    product is MODIS BRDF-corrected imagery (MCD43B4), which was gap-filled
    using the approach outlined in Weiss et al. (2014) to eliminate missing
    data caused by factors such as cloud cover. After gap-filling the data was clipped to thresholds of [0, 1] to ensure valid values. 

    The gap-filled 8-daily ~1km outputs are then aggregated temporally to produce monthly and annual products.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['vegetation-indices'],
  keywords: [
    'map',
    'evi', 'vegetation'
  ],
  providers: [
    ee.producer_provider('The Malaria Atlas Project', 'https://www.malariaatlas.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-02-01T00:00:00Z' , null),
  summaries: {
    gsd: [
      5000.0,
    ],
    'eo:bands': [
      {
        name: 'Mean',
        description: 'The mean value of the Enhanced Vegetation Index for each aggregated pixel.',
        
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Enhanced Vegetation Index',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [1.0],
            palette: ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'],
            bands: [
              'Mean',
            ],
          },
        },
      },
    ],
    Mean: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Weiss, D.J., P.M. Atkinson, S. Bhatt, B. Mappin, S.I. Hay & P.W. Gething
    (2014) An effective approach for gap-filling continental scale remotely
    sensed time-series. ISPRS Journal of Photogrammetry and Remote Sensing,
    98, 106-118. 
    [doi:10.1016/j.isprsjprs.2014.10.001](https://doi.org/10.1016/j.isprsjprs.2014.10.001)
  |||,
  
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}