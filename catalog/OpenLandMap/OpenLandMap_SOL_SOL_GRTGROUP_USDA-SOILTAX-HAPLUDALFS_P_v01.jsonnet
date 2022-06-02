local id = 'OpenLandMap/SOL/SOL_GRTGROUP_USDA-SOILTAX-HAPLUDALFS_P/v01';
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
  title: 'OpenLandMap Predicted Hapludalfs Probability',
  'gee:type': ee_const.gee_type.image,
  description: |||
    Predicted USDA soil great groups at 250 m (probabilities).

    Distribution of the USDA soil great groups based on machine learning predictions
    from global compilation of soil profiles. To learn more about soil great groups
    please refer to the [Illustrated Guide to Soil Taxonomy - NRCS - USDA](https://www.nrcs.usda.gov/wps/PA_NRCSConsumption/download/?cid=stelprdb1247203.pdf)
    . Processing steps are described in detail [here](https://gitlab.com/openlandmap/global-layers/tree/master/soil)
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
      href: 'https://doi.org/10.5281/zenodo.1476844',
    },
  ],
  keywords: [
    'argillic',
    'envirometrix',
    'hapludalfs',
    'opengeohub',
    'openlandmap',
  ],
  providers: [
    ee.producer_provider('EnvirometriX Ltd', 'https://doi.org/10.5281/zenodo.1476844'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      250.0,
    ],
    'eo:bands': [
      {
        name: 'grtgroup',
        description: 'Predicted Hapludalfs probability',
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Hapludalfs',
        image_visualization: {
          global_vis: {
            min: [
              0.0,
            ],
            max: [
              35.0,
            ],
            palette: [
              'ffffb2',
              'fecc5c',
              'fd8d3c',
              'f03b20',
              'bd0026',
            ],
            bands: [
              'grtgroup',
            ],
          },
        },
      },
    ],
    grtgroup: {
      minimum: 0.0,
      maximum: 35.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5281/zenodo.1476844',
  'sci:citation': |||
    Tomislav Hengl, & Travis Nauman. (2018). Predicted USDA soil great groups at 250 m (probabilities) (Version v01) [Data set]. Zenodo.
    [10.5281/zenodo.1476844](https://doi.org/10.5281/zenodo.1476844)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution Share Alike 4.0 International License.',
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
