local id = 'projects/mangrovedatahub2/assets/CGMD-Extent30';
local subdir = 'mangrovedatahub2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],

  id: id,
  title: 'Global Annual Mangrove Extent (1984-2023)',
  version: '1.0',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.table,

  description: |||
    The CGMD-Extent30 (Continuous Global Mangrove Dynamics-Annual Mangrove Extent at 30-m resolution) dataset provides global annual mangrove extent from 1984 to 2023. 
    The dataset is distributed as a single Earth Engine `FeatureCollection`, with each feature representing a mapped mangrove polygon for a specific year.

    The dataset was generated from long-term Landsat time-series observations within the Google Earth Engine platform. 
    We first mapped mangrove extent for three baseline periods, representing the 1980s, 2010, and 2023, using cloud-free Landsat composites, 
    prior global mangrove maps, automatically derived training samples, localized machine-learning classifiers, and post-classification refinements. 
    True mangrove loss and gain between baseline periods were then identified using a change-detection procedure, 
    and annual mangrove extent maps for intervening years were reconstructed using a temporal consistency algorithm.

    The dataset was validated using independent reference samples. For static mangrove extent, 
    global user's and producer's accuracies were approximately 90%. For mangrove change, including loss and gain, 
    user's and producer's accuracies were approximately 80%.

    This dataset is designed to support large-scale analyses of long-term mangrove area dynamics, 
    including loss, gain, persistence, coastal ecosystem monitoring, and blue carbon assessment. 

    Because the dataset is provided at annual temporal resolution, the timing of detected changes should be interpreted at the yearly scale. 
    Changes that occurred late in a calendar year may be detected in the following annual map, resulting in a potential temporal offset of up to one year. 
    In addition, transient mangrove losses lasting less than three years were treated as degradation rather than persistent extent loss; 
    therefore, these areas remain classified as mangroves in the annual extent product.
    For quick visualization and exploratory analysis, users are encouraged to access 
    [the CGMD Earth Engine App](https://zhenzhang.users.earthengine.app/view/globalmangrovedynamic).
  |||,

  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://zenodo.org/records/17204134',
    },
  ],

  'gee:categories': [
    'forest-biomass',
    'landuse-landcover',
  ],

  keywords: [
    'mangrove',
    'wetland',
    'coastal',
    'landsat_derived',
    'annual',
    'global',
  ],

  providers: [
    ee.producer_provider('The Mangrove Lab', 'https://www.themangrovelab.com/'),
    ee.producer_provider('Dr. Zhen Zhang', 'https://gis-zhangzhen.github.io/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('1984-01-01T00:00:00Z', '2023-12-31T23:59:59Z'),

  summaries: {
    'gee:schema': [
      {
        name: 'year',
        description: 'Data year, ranging from 1984 to 2023.',
        type: ee_const.var_type.int,
      },
      {
        name: 'gridcode',
        description: 'Source flag for the mapped mangrove extent. A value of 1 indicates extent derived from clear Landsat observations; a value of 2 indicates gap-filled extent using the latest available clear Landsat observation.',
        type: ee_const.var_type.int,
      },
      {
        name: 'area_km2',
        description: 'Polygon area in square kilometers, calculated under the Behrmann equal-area projection.',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mangrove extent',
        lookat: {
          lat: 0.0,
          lon: 110.0,
          zoom: 3,
        },
        table_visualization: {
          color: '006400',
        },
      },
      {
        display_name: 'Mangrove extent FeatureView',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1000,
      thinning_strategy: 'HIGHER_DENSITY',
      prerender_tiles: true,
    },
  },

  

  'sci:citation': |||
    Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026). Unexpected expansion and regrowth in Earth's mangrove forests over the past four decades. Science. https://doi.org/10.1126/science.aec9773
  |||,

  'sci:publications': [
    {
      citation: |||
        Zhang, Z., Murray, N., Song, X., ... & Friess, D. (2026). Unexpected expansion and regrowth in Earth's mangrove forests over the past four decades. Science. https://doi.org/10.1126/science.aec9773
      |||,
      doi: '10.1126/science.aec9773',
    },
  ],

  'gee:terms_of_use': |||
    Acknowledgements

    Users should cite the associated scientific paper and the Zenodo data record when using this dataset in publications or derived products.

    License

    The dataset is licensed under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
  |||,

  'gee:user_uploaded': true,
}