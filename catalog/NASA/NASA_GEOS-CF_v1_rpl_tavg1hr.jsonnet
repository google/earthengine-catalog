local id = 'NASA/GEOS-CF/v1/rpl/tavg1hr';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'NASA_GEOS-CF_v1.libsonnet';
local units = import 'units.libsonnet';

local tavg1hr_bands = import 'NASA_GEOS-CF_tavg1hr.libsonnet';

local license = spdx.proprietary;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  'gee:type': ee_const.gee_type.image_collection,
  title: 'GEOS-CF rpl tavg1hr v1: Goddard Earth Observing System Composition Forecast',
  version: 'v1',
  description: |||
    This dataset contains meteorological replay (rpl) of time-average one hour
    data (tavg1hr). It is built by merging the original GEOS-CF collections
    chm_tavg_1hr_g1440x721_v1, met_tavg_1hr_g1440x721_x1, and
    xgc_tavg_1hr_g1440x721_x1.
  ||| + template.description,
  'sci:citation': template.sci_citation,
  'sci:doi': '10.1029/2020MS002413',
  providers: [
    ee.producer_provider(
      'NASA / GMAO',
      'https://gmao.gsfc.nasa.gov/weather_prediction/GEOS-CF/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  license: license.id,
  links: ee.standardLinks(subdir, id),
  extent: ee.extent_global('2018-01-01T00:00:00Z', null),
  'gee:categories': ['atmosphere'],
  keywords: [
    'composition',
    'forecast',
    'geos',
    'gmao',
    'nasa',
  ],
  'gee:terms_of_use': template.gee_terms_of_use,
  summaries: {
    gsd: [
      27750.0,
    ],
    'eo:bands': tavg1hr_bands.bands_common,
    'gee:visualizations': [
      {
        display_name: 'Temperature',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              220,
            ],
            max: [
              320,
            ],
            // We may want to use a more visually distinct palette. Here and in
            // the JS example as well.
            palette: [
              'd7191c',
              'fdae61',
              'ffffbf',
              'abd9e9',
              '2c7bb6',
            ],
            bands: [
              'T',
            ],
          },
        },
      },
      {
        display_name: 'NO2',
        lookat: {
          lat: 20.0,
          lon: 100.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              6.96e-11,
            ],
            max: [
              4.42e-8,
            ],
            bands: [
              'NO2',
            ],
          },
        },
      },
    ],
  },
}
