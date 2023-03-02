local id = 'Oxford/MAP/TCB_5km_Monthly';
local subdir = 'Oxford';

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
  title: 'Oxford MAP TCB: Malaria Atlas Project Gap-Filled Tasseled Cap Brightness',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This gap-filled Tasseled Cap Brightness (TCB) dataset was created by
    applying the tasseled-cap equations defined in Lobser and Cohen (2007) to
    MODIS BRDF-corrected imagery (MCD43B4). The resulting data were gap-filled
    using the approach outlined in Weiss et al. (2014) to eliminate missing
    data caused by factors such as cloud cover, and then the data were
    aggregated temporally and spatially to produce the monthly ≈5km product.

    This dataset was produced by Harry Gibson and Daniel Weiss of the
    [Malaria Atlas Project](https://malariaatlas.org/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'brightness',
    'map',
    'oxford',
    'tasseled_cap',
    'tcb',
  ],
  providers: [
    ee.producer_provider('Oxford Malaria Atlas Project', 'https://www.bdi.ox.ac.uk/research/malaria-atlas-project'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-02-01T00:00:00Z', '2015-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      5000.0,
    ],
    'eo:bands': [
      {
        name: 'Mean',
        description: 'The mean value of Tasseled Cap Brightness for each aggregated pixel.',
      },
      {
        name: 'FilledProportion',
        description: |||
          A quality control band that indicates the percentage of
          each resulting pixel that was comprised of raw data (as opposed to
          gap-filled estimates).
        |||,
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'TCB',
        lookat: {
          lat: 22.59,
          lon: -44.65,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.3,
            ],
            palette: [
              '011301',
              '004c00',
              '056201',
              '207401',
              '3e8601',
              '66a000',
              '99b718',
              'fcd163',
              'ffffff',
            ],
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
    FilledProportion: {
      minimum: 0.0,
      maximum: 100.0,
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
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}
