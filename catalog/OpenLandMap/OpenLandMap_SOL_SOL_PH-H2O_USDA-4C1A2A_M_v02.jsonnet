local id = 'OpenLandMap/SOL/SOL_PH-H2O_USDA-4C1A2A_M/v02';
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
  title: 'OpenLandMap Soil pH in H2O',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Soil pH in H2O at 6 standard depths (0, 10, 30, 60, 100 and 200 cm) at 250 m resolution

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
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5281/zenodo.1475459',
    },
  ],
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
              'FF0000',
              'FF1C00',
              'FF3900',
              'FF5500',
              'FF7100',
              'FF8E00',
              'FFAA00',
              'FFC600',
              'FFE200',
              'FFFF00',
              'E3FF00',
              'C7FF00',
              'AAFF00',
              '8EFF00',
              '72FF00',
              '55FF00',
              '39FF00',
              '1DFF00',
              '01FF00',
              '00FF1C',
              '00FF38',
              '00FF54',
              '00FF71',
              '00FF8D',
              '00FFA9',
              '00FFC6',
              '00FFE2',
              '00FFFE',
              '00E3FF',
              '00C7FF',
              '00ABFF',
              '008FFF',
              '0072FF',
              '0056FF',
              '003AFF',
              '001DFF',
              '0001FF',
              '1B00FF',
              '3800FF',
              '5400FF',
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
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
