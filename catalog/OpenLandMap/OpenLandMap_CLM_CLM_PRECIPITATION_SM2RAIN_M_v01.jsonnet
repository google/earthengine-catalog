local id = 'OpenLandMap/CLM/CLM_PRECIPITATION_SM2RAIN_M/v01';
local subdir = 'OpenLandMap';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'OpenLandMap Precipitation Monthly',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Monthly precipitation in mm at 1 km resolution based on [SM2RAIN-ASCAT
    2007-2018](https://doi.org/10.5281/zenodo.2615278),
    IMERG, CHELSA Climate, and WorldClim.

    [Downscaled to 1 km resolution using gdalwarp](https://gitlab.com/openlandmap/global-layers/tree/master/input_layers/clim1km)
    (cubic splines) and an average between [WorldClim](https://www.worldclim.com/version2),
    [CHELSA Climate](https://chelsa-climate.org/),
    and [IMERG monthly product](ftp://jsimpson.pps.eosdis.nasa.gov/NRTPUB/imerg/gis/) (see, e.g, \\"3B-MO-L.GIS.IMERG.20180601.V05B.tif\\").
    3x higher weight is given to the SM2RAIN-ASCAT data since it assumed to be more accurate. Processing steps are available
    [**here**](https://gitlab.com/openlandmap/global-layers/tree/master/input_layers/clim1km)
    . Antartica is not included.

    To access and visualize maps outside of Earth Engine, use [this page](https://landgis.opengeohub.org).

    If you discover a bug, artifact or inconsistency in the LandGIS maps
    or if you have a question please use the following channels:

     *  [Technical issues and questions about the code](https://gitlab.com/openlandmap/global-layers/issues)
     *  [General questions and comments](https://disqus.com/home/forums/landgis/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://opendatacommons.org/licenses/odbl/1-0/'),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.1435912',
    },
  ],
  keywords: [
    'envirometrix',
    'imerg',
    'monthly',
    'opengeohub',
    'openlandmap',
    'precipitation',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1435912'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2007-01-01T00:00:00Z', '2019-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'jan',
        description: 'Jan Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'feb',
        description: 'Feb Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'mar',
        description: 'Mar Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'apr',
        description: 'Apr Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'may',
        description: 'May Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'jun',
        description: 'Jun Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'jul',
        description: 'Jul Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'aug',
        description: 'Aug Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'sep',
        description: 'Sep Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'oct',
        description: 'Oct Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'nov',
        description: 'Nov Precipitation monthly',
        'gee:units': 'mm',
      },
      {
        name: 'dec',
        description: 'Dec Precipitation monthly',
        'gee:units': 'mm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation monthly in mm',
        image_visualization: {
          global_vis: {
            min: [
              0.0,
            ],
            max: [
              380.0,
            ],
            palette: [
              'ecffbd',
              'ffff00',
              '3af6ff',
              '467aff',
              '313eff',
              '0008ff',
            ],
            bands: [
              'jan',
            ],
          },
        },
      },
    ],
    jan: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    feb: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    mar: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    apr: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    may: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    jun: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    jul: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    aug: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    sep: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    oct: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    nov: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
    dec: {
      minimum: 0.0,
      maximum: 380.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1435912',
  'sci:citation': |||
    Monthly precipitation in mm at 1 km resolution based on SM2RAIN-ASCAT 2007-2018 and IMERG 2014-2018
    [10.5281/zenodo.1435912](https://doi.org/10.5281/zenodo.1435912)
  |||,
  'gee:terms_of_use': |||
    This is a human-readable summary of (and not a substitute for) the [license](https://creativecommons.org/licenses/by-sa/4.0/).

    You are free to -
      Share — copy and redistribute the material in any medium or format
      Adapt — remix, transform, and build upon the material for any purpose, even commercially.

    This license is acceptable for Free Cultural Works.
    The licensor cannot revoke these freedoms as long as you follow the license terms.

    Under the following terms -
      Attribution — You must give appropriate credit, provide a link to the license, and indicate if
      changes were made. You may do so in any reasonable manner, but not in any way that suggests the
      licensor endorses you or your use.

      ShareAlike — If you remix, transform, or build upon the material, you must distribute your
      contributions under the same license as the original.

      No additional restrictions — You may not apply legal terms or technological measures that
      legally restrict others from doing anything the license permits.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
