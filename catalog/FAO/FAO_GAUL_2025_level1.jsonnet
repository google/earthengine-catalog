local id = 'FAO/GAUL/2025/level1';
local subdir = 'FAO';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/GAUL_level1_versions.libsonnet';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title:
    'FAO GAUL: Global Administrative Unit Layers 2025, ' +
    'First-Level Administrative Units',
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
    The administrative boundaries dataset at level 1 (sub-national level) is part
    of the Global Administrative Unit Layers (GAUL 2025) dataset series which
    includes information on administrative units for all countries in the world,
    providing a contribution to the standardization of the spatial dataset
    representing administrative units.

    The administrative boundaries at the level 1 dataset distinguishes States,
    Provinces, Departments and equivalents.

    The GAUL maintains global layers with a unified coding system at country,
    first (e.g. departments), and second administrative levels (e.g. districts).
    The overall GAUL methodology consists in a) collecting the best available
    data from most reliable sources, b) assembling national datasets into a
    common dataset by matching international boundaries with a reference
    authoritative dataset (UN 2018), c) standardizing attributes to a common
    table of attributes, d) generating codes using the GAUL Coding System,
    e) applying a topology, and f) validating metadata for each country
    (see [Technical Guidelines of the GAUL 2024 Set](
      https://data.apps.fao.org/catalog/dataset/0309530a-fc32-4115-8f68-0dffcdbaca15/resource/fdf27f3c-670b-46df-b1d0-ce886a2953d0/download/gaul2024_technicalguidelines.pdf)).
    Note that some administrative units are multipolygon features.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ] + version_config.version_links,
  'gee:categories': ['infrastructure-boundaries'],
  keywords: [
    'borders',
    'departments',
    'fao',
    'gaul',
    'provinces',
    'states',
    'un',
  ],
  providers: [
    ee.producer_provider(
      'FAO UN',
      'https://data.apps.fao.org/catalog/dataset/global-administrative-unit-layers-gaul-2025'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2025-01-01T00:00:00Z', '2025-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'FID',
        description: 'Internal feature identifier',
        type: ee_const.var_type.int,
      },
      {
        name: 'ISO3_CODE',
        description: 'ISO 3166-1 alpha-3 country code',
        type: ee_const.var_type.string,
      },
      {
        name: 'MAP_CODE',
        description: 'Map code for statistical joins',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAUL0_CODE',
        description: 'GAUL country code',
        type: ee_const.var_type.int,
      },
      {
        name: 'GAUL0_NAME',
        description: 'Country name (UN standard)',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAUL1_CODE',
        description: 'GAUL code of administrative units at first level',
        type: ee_const.var_type.int,
      },
      {
        name: 'GAUL1_NAME',
        description: 'Name of administrative units at first level',
        type: ee_const.var_type.string,
      },
      {
        name: 'CONTINENT',
        description: 'Continent name',
        type: ee_const.var_type.string,
      },
      {
        name: 'DISP_EN',
        description: 'Hierarchical display label in English',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'First Level Administrative Units',
        lookat: {lon: 7.82, lat: 49.1, zoom: 4},
        polygon_visualization: {
          property_name: 'GAUL1_CODE',
          property_vis: {
            min: [1000],
            max: [10000],
            palette: [
              '00ff97', 'ddff6b', 'f0ff6b', 'ffe96b', '7277ff', 'ffffb3',
              'daffff', 'b0ffff', '72ffff', 'a9ff6b', '72d6ff', '00ff72',
              '00eee3', 'ff84ff', 'e1e4e1', 'ecffe1', 'b3c59f', 'b3f09f',
              'ffffca', '47f09f', 'dadce7', '47f0d7', 'ffa789', '00ffbb',
              'd3ff89', '00b6ff', 'cfcdca', 'ff7789', 'cfbaca', 'ffe5c8',
              'ffd1ff', 'ff7789', 'ffff89', 'd3a789', '0cffff', 'ff87a8',
              'd8ff6a', 'd8ddbb',
            ],
          },
        },
      },
      {
        display_name: 'First Level Administrative Units',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 4000,
      min_vertices_per_tile: 50000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['FID ASC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    FAO. 2025. Global Administrative Unit Layers (GAUL). https://data.apps.fao.org. Licence: CC-BY-4.0
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
