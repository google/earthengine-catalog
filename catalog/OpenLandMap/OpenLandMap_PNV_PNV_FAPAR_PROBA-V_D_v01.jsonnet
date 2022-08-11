local id = 'OpenLandMap/PNV/PNV_FAPAR_PROBA-V_D/v01';
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
  title: 'OpenLandMap Potential FAPAR Monthly',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Potential Natural Vegetation FAPAR predicted monthly median (based on PROB-V FAPAR 2014-2017).
    [Description](https://gitlab.com/openlandmap/global-layers/#potential-natural-vegetation).

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
      href: 'https://doi.org/10.7910/DVN/QQHCIK',
    },
  ],
  keywords: [
    'envirometrix',
    'fapar',
    'monthly',
    'opengeohub',
    'openlandmap',
    'potential',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.7910/DVN/QQHCIK'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', '2002-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'jan',
        description: 'Jan Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'feb',
        description: 'Feb Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'mar',
        description: 'Mar Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'apr',
        description: 'Apr Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'may',
        description: 'May Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'jun',
        description: 'Jun Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'jul',
        description: 'Jul Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'aug',
        description: 'Aug Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'sep',
        description: 'Sep Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'oct',
        description: 'Oct Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'nov',
        description: 'Nov Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'dec',
        description: 'Dec Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'annual',
        description: 'Anuual Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
      {
        name: 'annualdiff',
        description: 'Annual Difference Potential FAPAR monthly',
        'gee:units': 'fraction',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Potential FAPAR monthly',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          global_vis: {
            min: [
              0.0,
            ],
            max: [
              220.0,
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
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    feb: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    mar: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    apr: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    may: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    jun: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    jul: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    aug: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    sep: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    oct: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    nov: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    dec: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    annual: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
    annualdiff: {
      minimum: 0.0,
      maximum: 220.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7910/DVN/QQHCIK',
  'sci:citation': |||
    Hengl T, Walsh MG, Sanderman J, Wheeler I, Harrison SP, Prentice IC. (2018) Global Mapping of Potential Natural Vegetation: An Assessment of Machine Learning Algorithms for Estimating Land Potential. PeerJ Preprints.
    [10.7287/peerj.preprints.26811v5](https://doi.org/10.7910/DVN/QQHCIK)
  |||,
  'gee:terms_of_use': |||
    This is a human-readable summary of (and not a substitute for) the [license](https://creativecommons.org/licenses/by-sa/4.0/).

    You are free to -
      Share - copy and redistribute the material in any medium or format
      Adapt - remix, transform, and build upon the material for any purpose, even commercially.

    This license is acceptable for Free Cultural Works.
    The licensor cannot revoke these freedoms as long as you follow the license terms.

    Under the following terms -
      Attribution - You must give appropriate credit, provide a link to the license, and indicate if
      changes were made. You may do so in any reasonable manner, but not in any way that suggests the
      licensor endorses you or your use.

      ShareAlike - If you remix, transform, or build upon the material, you must distribute your
      contributions under the same license as the original.

      No additional restrictions - You may not apply legal terms or technological measures that
      legally restrict others from doing anything the license permits.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
