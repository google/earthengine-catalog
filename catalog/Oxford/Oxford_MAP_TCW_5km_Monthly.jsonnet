local id = 'Oxford/MAP/TCW_5km_Monthly';
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
    ee_const.ext_ver,
  ],
  id: id,
  version: ee_const.version_unknown,
  'gee:status': 'deprecated',
  title: 'Oxford MAP TCW: Malaria Atlas Project Gap-Filled Tasseled Cap Wetness [deprecated]',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This gap-filled Tasseled Cap Wetness (TCW) dataset was created by applying
    the tasseled-cap equations defined in Lobser and Cohen (2007) to
    MODIS BRDF-corrected imagery (MCD43B4). The resulting data were
    gap-filled using the approach outlined in Weiss et al. (2014) to eliminate
    missing data caused by factors such as cloud cover, and then the data were
    aggregated temporally and spatially to produce the monthly &asymp;5km product.

    This dataset was produced by Harry Gibson and Daniel Weiss of the
    Malaria Atlas Project (Big Data Institute, University of Oxford,
    United Kingdom, [https://malariaatlas.org/](https://malariaatlas.org/)).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ee.link.successor(
        'projects/malariaatlasproject/assets/TCW_v061/1km/Monthly',
        ee_const.catalog_base + 'malariaatlasproject/projects_malariaatlasproject_assets_TCW_v061_1km_Monthly.json'),
  ],
  'gee:categories': ['vegetation-indices'],
  keywords: [
    'map',
    'oxford',
    'tasseled_cap',
    'tcb',
    'wetness',
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
        description: 'The mean value of Tasseled Cap Wetness for each aggregated pixel.',
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
        display_name: 'TCW',
        lookat: {
          lat: 22.59,
          lon: -44.65,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.6,
            ],
            max: [
              0.5,
            ],
            palette: [
              'ffffff',
              'fcd163',
              '99b718',
              '66a000',
              '3e8601',
              '207401',
              '056201',
              '004c00',
              '011301',
            ],
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
