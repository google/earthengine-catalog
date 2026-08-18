local id = 'projects/nature-trace/assets/farmscapes/england_v1_0_vectorised';
local subdir = 'nature-trace';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Farmscapes 2020 Vectorised',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:type': ee_const.gee_type.table,
  stac_extensions: [
    ee_const.ext_sci,
  ],

  description: |||
    This is the vectorised version of the [Farmscapes 2020](projects_nature-trace_assets_farmscapes_england_v1_0)
    raster dataset. It provides polygon geometries representing fine-scale
    semi-natural landscape features (specifically hedgerows, woodland, and stone
    walls) across England's agricultural landscapes. This dataset was developed
    in collaboration with the Oxford Leverhulme Centre for Nature Recovery to
    serve as a baseline for applications including landscape restoration,
    biodiversity monitoring, and ecological connectivity analysis.

    It is derived by vectorising the high-resolution (25cm) Farmscapes 2020
    probability maps, filtered to exclude 'hedge gap' features, and simplified
    to retain only the feature classification attribute.

    **Limitations**

    * Geographic Scope: Model performance is reduced in dense urban
    environments and mountainous areas, which were underrepresented in the
    training data that focused primarily on rural landscapes.
    * Temporal Accuracy: The source imagery was captured between 2018 and 2020.
    Consequently, the dataset does not account for landscape changes that have
    occurred since this period.
    * Class-Specific performance: The stone wall class exhibits lower
    accuracy compared to woodland and hedgerows, a result of
    significant class imbalance in the training data.
  |||,

  'gee:categories': ['landuse-landcover'],

  keywords: [
    'biodiversity',
    'conservation',
    'climate',
    'ecological-connectivity',
    'forest',
  ],

  providers: [
    ee.producer_provider('Google', 'https://research.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2018-01-01T00:00:00Z', '2020-12-31T23:59:59Z'),

  summaries: {
    'gee:schema': [
      {
        name: 'feature_name',
        description: 'The type of the landscape feature: "hedgerow", "copse", "linear_woodland", "stone wall", or "woodland".',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Farmscapes Vectors (FeatureView)',
        visualize_as: 'FeatureView',
      },
      {
        display_name: 'Farmscapes Vectors (Table Outline)',
        lookat: { lon: -1.38, lat: 51.72, zoom: 14 },
        table_visualization: {
          color: '808080',
          fill_color: '80808040',
          width: 1,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },

  'sci:citation': |||
    Michelangelo Conserva, Alex Wilson, Charlotte Stanton, Vishal Batchu, Varun
    Gulshan , "Mapping Farmed Landscapes from Remote Sensing" (in review).
    [doi:10.48550/arXiv.2506.13993](https://doi.org/10.48550/arXiv.2506.13993),
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],

  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced by Google".
  |||,
}
