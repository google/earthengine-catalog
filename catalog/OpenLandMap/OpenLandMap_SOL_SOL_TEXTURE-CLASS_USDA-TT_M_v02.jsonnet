local id = 'OpenLandMap/SOL/SOL_TEXTURE-CLASS_USDA-TT_M/v02';
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
  title: 'OpenLandMap Soil Texture Class (USDA System)',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil texture classes (USDA system) for 6 soil depths (0, 10, 30, 60, 100 and 200 cm) at 250 m

    Derived from predicted soil texture fractions using the soiltexture package in R.
    Processing steps are described in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil)
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
      rel: 'cite-as',
      href: 'https://doi.org/10.5281/zenodo.1475451',
    },
  ],
  keywords: [
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'soil',
    'texture',
    'usda',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1475451'),
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
        description: 'Soil texture class (USDA system) at 0 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
      {
        name: 'b10',
        description: 'Soil texture class (USDA system) at 10 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
      {
        name: 'b30',
        description: 'Soil texture class (USDA system) at 30 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
      {
        name: 'b60',
        description: 'Soil texture class (USDA system) at 60 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
      {
        name: 'b100',
        description: 'Soil texture class (USDA system) at 100 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
      {
        name: 'b200',
        description: 'Soil texture class (USDA system) at 200 cm depth',
        'gee:classes': [
          {
            value: 1,
            color: 'd5c36b',
            description: 'Cl',
          },
          {
            value: 2,
            color: 'b96947',
            description: 'SiCl',
          },
          {
            value: 3,
            color: '9d3706',
            description: 'SaCl',
          },
          {
            value: 4,
            color: 'ae868f',
            description: 'ClLo',
          },
          {
            value: 5,
            color: 'f86714',
            description: 'SiClLo',
          },
          {
            value: 6,
            color: '46d143',
            description: 'SaClLo',
          },
          {
            value: 7,
            color: '368f20',
            description: 'Lo',
          },
          {
            value: 8,
            color: '3e5a14',
            description: 'SiLo',
          },
          {
            value: 9,
            color: 'ffd557',
            description: 'SaLo',
          },
          {
            value: 10,
            color: 'fff72e',
            description: 'Si',
          },
          {
            value: 11,
            color: 'ff5a9d',
            description: 'LoSa',
          },
          {
            value: 12,
            color: 'ff005b',
            description: 'Sa',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil texture class (USDA system)',
        image_visualization: {
          global_vis: {
            min: [
              1.0,
            ],
            max: [
              12.0,
            ],
            palette: [
              'd5c36b',
              'b96947',
              '9d3706',
              'ae868f',
              'f86714',
              '46d143',
              '368f20',
              '3e5a14',
              'ffd557',
              'fff72e',
              'ff5a9d',
              'ff005b',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5281/zenodo.1475451',
  'sci:citation': |||
    Tomislav Hengl. (2018). Soil texture classes (USDA system) for 6 soil depths (0, 10, 30, 60, 100 and 200 cm) at 250 m (Version v02) [Data set]. Zenodo.
    [10.5281/zenodo.1475451](https://doi.org/10.5281/zenodo.1475451)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
