local id = 'projects/covariate/assets/TCB_v061/5km/8-Daily';
local subdir = 'MalariaAtlasProject';

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
  title: '8-Daily TCB: Malaria Atlas Project Gap-Filled Tasseled Cap Brightness',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This gap-filled Tasseled Cap Brightness (TCB) dataset was created by
    applying the tasseled-cap equations defined in Lobser and Cohen (2007) to
    MODIS BRDF-corrected imagery (MCD43B4). The resulting data were gap-filled
    using the approach outlined in Weiss et al. (2014) to eliminate missing
    data caused by factors such as cloud cover, and then the data were
    aggregated temporally and spatially to produce the monthly &asymp;5km product.

  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'map',
    'tcb', 'vegetation', 'tasseled_cap', 'brightness'
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
        description: 'The mean value of Tasseled Cap Brightness for each aggregated pixel.',
        
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Tasseled Cap Brightness',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [1.3],
            palette: ['011301','004c00','056201','207401','3e8601','66a000','99b718','fcd163','ffffff'],
            bands: [
              'Mean',
            ],
          },
        },
      },
    ],
    Mean: {
      minimum: 0.0,
      maximum: 1.99,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Weiss, D.J., P.M. Atkinson, S. Bhatt, B. Mappin, S.I. Hay & P.W. Gething
    (2014) An effective approach for gap-filling continental scale remotely
    sensed time-series. ISPRS Journal of Photogrammetry and Remote Sensing,
    98, 106-118.
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