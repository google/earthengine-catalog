local id = 'OpenLandMap/SOL/SOL_ORGANIC-CARBON_USDA-6A1C_M/v02';
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
  title: 'OpenLandMap Soil Organic Carbon Content',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil organic carbon content in x 5 g / kg at 6 standard depths
    (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution

    Predicted from a global compilation of soil points. Processing steps are described
    in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil).
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
      href: 'https://doi.org/10.5281/zenodo.1475457',
    },
  ],
  keywords: [
    'carbon',
    'envirometrix',
    'opengeohub',
    'openlandmap',
    'organic',
    'soil',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1475457'),
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
        description: 'Soil organic carbon content at 0 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
      {
        name: 'b10',
        description: 'Soil organic carbon content at 10 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
      {
        name: 'b30',
        description: 'Soil organic carbon content at 30 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
      {
        name: 'b60',
        description: 'Soil organic carbon content at 60 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
      {
        name: 'b100',
        description: 'Soil organic carbon content at 100 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
      {
        name: 'b200',
        description: 'Soil organic carbon content at 200 cm depth',
        'gee:units': 'g/kg',
        'gee:scale': 5.0,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil organic carbon content in x 5 g / kg',
        lookat: {
          lon: -5.6,
          lat: 30.7,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              120.0,
            ],
            palette: [
              'ffffa0',
              'f7fcb9',
              'd9f0a3',
              'addd8e',
              '78c679',
              '41ab5d',
              '238443',
              '005b29',
              '004b29',
              '012b13',
              '00120b',
            ],
            bands: [
              'b0',
            ],
          },
        },
      },
    ],
    b0: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
    b10: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
    b30: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
    b60: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
    b100: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
    b200: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1475457',
  'sci:citation': |||
    Tomislav Hengl, & Ichsani Wheeler. (2018). Soil organic carbon content in x 5 g / kg at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution (Version v02) [Data set]. Zenodo.
    [10.5281/zenodo.1475457](https://doi.org/10.5281/zenodo.1475457)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
