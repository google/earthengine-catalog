local id = 'OpenLandMap/SOL/SOL_PH-H2O_USDA-4C1A2A_M/v02';
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
  title: 'OpenLandMap Soil pH in H2O',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil pH in H2O at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution

    Processing steps are described in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil).
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
      href: 'https://doi.org/10.5281/zenodo.1475459',
    },
  ],
  'gee:categories': ['soil'],
  keywords: [
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'ph',
    'soil',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1475459'),
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
        description: 'Soil pH in H2O at 0 cm depth',
        'gee:scale': 10.0,
      },
      {
        name: 'b10',
        description: 'Soil pH in H2O at 10 cm depth',
        'gee:scale': 10.0,
      },
      {
        name: 'b30',
        description: 'Soil pH in H2O at 30 cm depth',
        'gee:scale': 10.0,
      },
      {
        name: 'b60',
        description: 'Soil pH in H2O at 60 cm depth',
        'gee:scale': 10.0,
      },
      {
        name: 'b100',
        description: 'Soil pH in H2O at 100 cm depth',
        'gee:scale': 10.0,
      },
      {
        name: 'b200',
        description: 'Soil pH in H2O at 200 cm depth',
        'gee:scale': 10.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil pH x 10 in H2O',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              42.0,
            ],
            max: [
              110.0,
            ],
            palette: [
              'ff0000',
              'ff1c00',
              'ff3900',
              'ff5500',
              'ff7100',
              'ff8e00',
              'ffaa00',
              'ffc600',
              'ffe200',
              'ffff00',
              'e3ff00',
              'c7ff00',
              'aaff00',
              '8eff00',
              '72ff00',
              '55ff00',
              '39ff00',
              '1dff00',
              '01ff00',
              '00ff1c',
              '00ff38',
              '00ff54',
              '00ff71',
              '00ff8d',
              '00ffa9',
              '00ffc6',
              '00ffe2',
              '00fffe',
              '00e3ff',
              '00c7ff',
              '00abff',
              '008fff',
              '0072ff',
              '0056ff',
              '003aff',
              '001dff',
              '0001ff',
              '1b00ff',
              '3800ff',
              '5400ff',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
    b0: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
    b10: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
    b30: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
    b60: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
    b100: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
    b200: {
      minimum: 42.0,
      maximum: 110.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1475459',
  'sci:citation': |||
    Tomislav Hengl. (2018). Soil pH in H2O at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution (Version v02) [Data set]. Zenodo.
    [10.5281/zenodo.1475459](https://doi.org/10.5281/zenodo.1475459)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
