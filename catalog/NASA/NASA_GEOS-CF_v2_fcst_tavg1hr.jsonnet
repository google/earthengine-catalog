local id = 'NASA/GEOS-CF/v2/fcst/tavg1hr';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'NASA_GEOS-CF_v2.libsonnet';
local units = import 'units.libsonnet';

local tavg1hr_bands = import 'NASA_GEOS-CF_v2_tavg1hr.libsonnet';

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
  title: 'GEOS-CF fcst tavg1hr v2: Goddard Earth Observing System Composition Forecast',
  version: 'v2',
  description: |||
    This dataset contains forecast (fcst) of time-averaged
    frequency data (tavg1hr). It is built by merging the original GEOS-CF collections
    chm_tavg_1hr_glo_L1440x721_slv, met_tavg_1hr_glo_L1440x721_slv, and
    xgc_tavg_1hr_glo_L1440x721_slv. Use the 'creation_time' and 'forecast_time' properties
    to select data of interest.
  ||| + template.description,
  'sci:citation': template.sci_citation,
  'sci:doi': '10.1029/2020MS002413',
  providers: [
    ee.producer_provider(
      'NASA / GMAO',
      'https://gmao.gsfc.nasa.gov/gmao-products/geos-cf/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  license: license.id,
  links: ee.standardLinks(subdir, id),
  extent: ee.extent_global('2025-08-04T00:00:00Z', null),
  'gee:categories': ['atmosphere'],
  keywords: [
    'composition',
    'forecast',
    'geos',
    'geos-cf',
    'gmao',
    'nasa',
  ],
  'gee:terms_of_use': template.gee_terms_of_use,
  summaries: {
    'gee:schema': [
      {
        name: 'creation_time',
        description: 'Time of creation',
        type: ee_const.var_type.double,
      },
      {
        name: 'forecast_time',
        description: 'Forecast time',
        type: ee_const.var_type.double,
      },
    ],
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
        display_name: 'Nitrogen Dioxide',
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
