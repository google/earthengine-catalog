local id = 'OpenLandMap/SOL/SOL_CLAY-WFRACTION_USDA-3A1A1A_M/v02';
local subdir = 'OpenLandMap';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_sa_4_0;

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
  title: 'OpenLandMap Clay Content',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Clay content in % (kg / kg) at 6 standard depths (0, 10, 30, 60,
    100 and 200 cm) at 250 m resolution

    Based on machine learning predictions from global compilation of soil profiles and samples. Processing
    steps are described in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil).
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
      href: 'https://doi.org/10.5281/zenodo.1476854',
    },
  ],
  'gee:categories': ['soil'],
  keywords: [
    'clay',
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'soil',
    'usda',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1476854'),
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
        description: 'Clay content at 0 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b10',
        description: 'Clay content at 10 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b30',
        description: 'Clay content at 30 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b60',
        description: 'Clay content at 60 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b100',
        description: 'Clay content at 100 cm depth',
        'gee:units': '% (kg / kg)',
      },
      {
        name: 'b200',
        description: 'Clay content at 200 cm depth',
        'gee:units': '% (kg / kg)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Clay content in % (kg / kg)',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              2.0,
            ],
            max: [
              100.0,
            ],
            palette: [
              'ffff00',
              'f8f806',
              'f1f10c',
              'ebeb13',
              'e4e419',
              'dddd20',
              'd7d726',
              'd0d02d',
              'caca33',
              'c3c33a',
              'bcbc41',
              'b6b647',
              'b0b04e',
              'a9a954',
              'a3a35a',
              '9c9c61',
              '959568',
              '8f8f6e',
              '898975',
              '82827b',
              '7b7b82',
              '757589',
              '6e6e8f',
              '686895',
              '61619c',
              '5a5aa3',
              '5454a9',
              '4d4db0',
              '4747b6',
              '4141bc',
              '3a3ac3',
              '3333ca',
              '2d2dd0',
              '2626d7',
              '2020dd',
              '1919e4',
              '1212eb',
              '0c0cf1',
              '0606f8',
              '0000ff',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
    b0: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b10: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b30: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b60: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b100: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
    b200: {
      minimum: 2.0,
      maximum: 100.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1476854',
  'sci:citation': |||
    Tomislav Hengl. (2018). Clay content in % (kg / kg) at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution (Version v02) [Data set].
    [10.5281/zenodo.1476854](https://doi.org/10.5281/zenodo.1476854)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
