local id = 'OpenLandMap/SOL/SOL_SAND-WFRACTION_USDA-3A1A1A_M/v02';
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
  title: 'OpenLandMap Sand Content',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Sand content in % (kg / kg) at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution

    Based on machine learning predictions from global compilation of soil profiles and samples.
    Processing steps are described in detail **[here](https://gitlab.com/openlandmap/global-layers/tree/master/soil)**
    . Antartica is not included.

    To access and visualize maps outside of Earth Engine, use [this page](https://landgis.opengeohub.org).

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
      href: 'https://doi.org/10.5281/zenodo.1476851',
    },
  ],
  keywords: [
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'sand',
    'soil',
    'usda',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1476851'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'b0',
        description: 'Sand content at 0 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b10',
        description: 'Sand content at 10 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b30',
        description: 'Sand content at 30 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b60',
        description: 'Sand content at 60 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b100',
        description: 'Sand content at 100 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b200',
        description: 'Sand content at 200 cm depth',
        'gee:units': '% (kg / kg)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sand content in % (kg / kg)',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          global_vis: {
            min: [
              1.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'FFFF00',
              'F8F806',
              'F1F10C',
              'EBEB13',
              'E4E419',
              'DDDD20',
              'D7D726',
              'D0D02D',
              'CACA33',
              'C3C33A',
              'BCBC41',
              'B6B647',
              'B0B04E',
              'A9A954',
              'A3A35A',
              '9C9C61',
              '959568',
              '8F8F6E',
              '898975',
              '82827B',
              '7B7B82',
              '757589',
              '6E6E8F',
              '686895',
              '61619C',
              '5A5AA3',
              '5454A9',
              '4D4DB0',
              '4747B6',
              '4141BC',
              '3A3AC3',
              '3333CA',
              '2D2DD0',
              '2626D7',
              '2020DD',
              '1919E4',
              '1212EB',
              '0C0CF1',
              '0606F8',
              '0000FF',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
    b0: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b10: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b30: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b60: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b100: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b200: {
      minimum: 1.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1476851',
  'sci:citation': |||
    Tomislav Hengl. (2018). Sand content in % (kg / kg) at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution (Version v02) [Data set].
    [10.5281/zenodo.1476851](https://doi.org/10.5281/zenodo.1476851)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
