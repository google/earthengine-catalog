local id = 'projects/malariaatlasproject/assets/TCW_v061/1km/8-Daily';
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
  title: 'TCW: Malaria Atlas Project Gap-Filled Tasseled Cap Wetness (8-Daily 1km)',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This gap-filled Tasseled Cap Wetness (TCW) dataset was created by applying
    the tasseled-cap equations defined in Lobser and Cohen (2007) to
    MODIS BRDF-corrected imagery (MCD43B4). The resulting data were
    gap-filled using the approach outlined in Weiss et al. (2014) to eliminate
    missing data caused by factors such as cloud cover. After gap-filling the data was clipped to thresholds of [-1, 2] to ensure valid values. 

    The gap-filled 8-daily ~1km outputs are then aggregated temporally to produce monthly and annual products, and aggregated spatially to produce ~5km products.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['vegetation-indices'],
  keywords: [
    'map',
    'tcw', 'vegetation', 'tasseled_cap', 'wetness'
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
        description: 'The mean value of Tasseled Cap Wetness for each aggregated pixel.',
        
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tassled Cap Wetness',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [-0.6],
            max: [0.5],
            palette: ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'],
            bands: [
              'Mean',
            ],
          },
        },
      },
    ],
    Mean: {
      minimum: -0.84,
      maximum: 0.96,
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
  'sci:publications': [
    {
      citation: |||
        Lobser, S.E. & Cohen, W.B. (2007) MODIS tasselled cap: land cover
        characteristics expressed through transformed MODIS data. International
        Journal of Remote Sensing, 28, 5079-5101.
      |||,
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}