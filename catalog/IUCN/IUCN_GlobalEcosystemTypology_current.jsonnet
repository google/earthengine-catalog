local id = 'IUCN/GlobalEcosystemTypology/current';
local subdir = 'IUCN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local spdx = import 'spdx.libsonnet';
local license = spdx.cc_by_4_0;

local version = '1.0';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  type: ee_const.stac_type.collection,
  id: id,
  version: version,
  title: 'IUCN Global Ecosystem Typology: 1.0',
  'gee:type': ee_const.gee_type.table,
  description: |||
      The Global Ecosystem Typology is a taxonomy of ecosystems based on
      their unique characteristics. It is a global classification system
      that provides a consistent framework for describing and classifying
      geological ecosystems.

      The IUCN Global Ecosystem Typology comprises six hierarchical levels,
      with the three upper levels, allowing navigation from global to local
      scales. The three upper levels: realms, functional biomes and ecosystem
      functional groups classify ecosystems based on their functional
      characteristics (such as structural roles of foundation species, water
      regime, climatic regime or food web structure), rather than based on which
      species live in them.

      The three lower levels of classification: biogeographic ecotypes, global
      ecosystem types and subglobal ecosystem types are often already in use and
      incorporated into policy infrastructure at national levels and can be
      linked to these upper levels. This is crucial, as important conservation
      action occurs at local levels, where most ecosystem-specific knowledge and
      data reside.
    |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: [
    'ecosystem',
    'global',
  ],
  providers: [
    ee.producer_provider(
      'International Union for Conservation of Nature and Natural Resources',
      'https://global-ecosystems.org/page/typology'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2023-09-14T00:00:00Z', '2023-09-14T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'efg_code',
        description: |||
          Ecosystem functional group code (e.g., "T1.1" = Tropical/Subtropical
          lowland rainforests). For a complete taxonomy, see
          [https://global-ecosystems.org/explore](https://global-ecosystems.org/explore).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'map_code',
        description: 'Map code',
        type: ee_const.var_type.string,
      },
      {
        name: 'map_version',
        description: 'Map version',
        type: ee_const.var_type.string,
      },
      {
        name: 'occurrence',
        description: |||
          It indicates whether the specified region contains major
          occurrences (1) or minor occurrences (2) of the functional group."
        |||,
        type: ee_const.var_type.int,
      }
  ],
    'gee:visualizations': [
      {
        display_name: 'Global Ecosystem Typology',
        table_visualization: {
        color: 'black',
        point_size: 1,
      },
      lookat: {
        lon: -63.873, lat: 46.194, zoom: 8},
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 250,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['Shape_Area DESC'],
    },
  },
  'gee:terms_of_use': |||
    Global Ecosystem Typology datasets are provided under the CC BY 4.0 license,
    which allows re-distribution and re-use of a licensed work on the condition
    that the creator is appropriately credited.
  |||,
  'sci:publications': [
    {
      citation: |||
        RT Pennington, J Franklin, NA Brummitt, A Etter, KR Young, RT Corlett
        and DA Keith. (2022). T1.2 Tropical/Subtropical dry forests and
        thickets. In: Keith, D.A., Ferrer-Paris, J.R., Nicholson,
        E. et al. (2022). A function-based typology for Earth's ecosystems
        - Appendix S4. The IUCN Global Ecosystem Typology v2.1: Descriptive
        profiles for Biomes and Ecosystem Functional Groups.
      |||,
      doi: '10.1038/s41586-022-05318-4',
    },
  ],
}
