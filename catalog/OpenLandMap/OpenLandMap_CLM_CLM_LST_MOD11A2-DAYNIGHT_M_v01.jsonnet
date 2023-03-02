local id = 'OpenLandMap/CLM/CLM_LST_MOD11A2-DAYNIGHT_M/v01';
local subdir = 'OpenLandMap';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_sa_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'OpenLandMap Long-term Land Surface Temperature Monthly Day-Night Difference',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Long-term MODIS LST day-time and night-time
    differences at 1 km based on the 2000-2017 time series

    Derived using the [data.table package and quantile function in R](https://gitlab.com/openlandmap/global-layers/tree/master/input_layers/MOD11A2).
    For more info about the MODIS LST product see [this page](https://lpdaac.usgs.gov/products/mod11a2v006/).
    Antarctica is not included.

    To access and visualize maps outside of Earth Engine, use [this page](https://opengeohub.org/about-openlandmap).

    If you discover a bug, artifact or inconsistency in the LandGIS maps
    or if you have a question please use the following channels:

     *  [Technical issues and questions about the code](https://gitlab.com/openlandmap/global-layers/issues)
     *  [General questions and comments](https://disqus.com/home/forums/landgis/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.1420114',
    },
  ],
  keywords: [
    'day',
    'envirometrix',
    'lst',
    'mod11a2',
    'modis',
    'monthly',
    'night',
    'opengeohub',
    'openlandmap',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1420114'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'jan',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'feb',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'mar',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'apr',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'may',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'jun',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'jul',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'aug',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'sep',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'oct',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'nov',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
      {
        name: 'dec',
        description: 'Long-term Land Surface Temperature monthly day-night difference',
        'gee:units': units.kelvin,
        'gee:scale': 0.02,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Long-term Land Surface Temperature monthly day-night difference',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              -40.5137,
            ],
            max: [
              1336.09,
            ],
            palette: [
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
            ],
            bands: [
              'jan',
            ],
          },
        },
      },
    ],
    jan: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    feb: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    mar: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    apr: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    may: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    jun: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    jul: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    aug: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    sep: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    oct: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    nov: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
    dec: {
      minimum: -40.5137,
      maximum: 1336.09,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1420114',
  'sci:citation': |||
    Long-term MODIS LST day-time and night-time temperatures, sd and differences
    at 1 km based on the 2000-2017 time series
    [10.5281/zenodo.1420116](https://doi.org/10.5281/zenodo.1420114)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
