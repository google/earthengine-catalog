local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'GOOGLE_Research_open-buildings_polygons_versions.libsonnet';

local subdir = 'GOOGLE';

local id = 'GOOGLE/Research/open-buildings/v1/polygons';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.cc_by_4_0;
{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Open Buildings V1 Polygons [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This large-scale open dataset consists of outlines of buildings derived
    from high-resolution 50 cm satellite imagery. It contains 516M building
    detections across an area of 19.4M km2 (64% of the African continent).

    For each building in this dataset we include the polygon describing its
    footprint on the ground, a confidence score indicating how sure we are that
    this is a building, and a [Plus Code](https://plus.codes/) corresponding to
    the center of the building. There is no information about the type of
    building, its street address, or any details other than its geometry.

    Building footprints are useful for a range of important applications: from
    population estimation, urban planning and humanitarian response to
    environmental and climate science. The project being based in Ghana, the
    current focus is on the continent of Africa.

    Inference was carried out during April 2021.

    For more details see the official
    [website](https://sites.research.google/open-buildings/) of the Open
    Buildings dataset.

    Note that updated versions of this data are available. The newest version,
    Version 3.0 (with inference carried out on May 2023), is available as
    [GOOGLE/Research/open-buildings/v3/polygons](GOOGLE_Research_open-buildings_v3_polygons).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(
      id, subdir, version_config.basename + '_FeatureView'),
    ee.link.license(license.reference)
  ] + version_config.version_links,
  keywords: [
    'africa',
    'building',
    'built_up',
    'open_buildings',
    'structure',
  ],
  providers: [
    ee.producer_provider('Google Research - Open Buildings', 'https://sites.research.google/open-buildings/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2021-04-30T00:00:00Z', '2021-04-30T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'area_in_meters',
        description: 'Area in square meters of the polygon.',
        type: ee_const.var_type.double,
        units: units.square_m,
      },
      {
        name: 'confidence',
        description: 'Confidence score [0.5;1.0] assigned by the model.',
        type: ee_const.var_type.double,
      },
      {
        name: 'full_plus_code',
        description: 'The full [Plus Code](https://plus.codes/) at the building polygon centroid.',
        type: ee_const.var_type.string,
      },
      {
        name: 'longitude_latitude',
        description: 'Centroid of the polygon.',
        type: ee_const.var_type.geometry,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Open Buildings V1',
        lookat: {
          lat: 6.492,
          lon: 3.389,
          zoom: 17,
        },
        table_visualization: {
          color: 'ffffff',
          fill_color: 'ffffff88',
        },
      },
      {
        display_name: 'Open Buildings V1',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'HIGHER_DENSITY',
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    W. Sirko, S. Kashubin, M. Ritter, A. Annkah, Y.S.E. Bouchareb, Y. Dauphin,
    D. Keysers, M. Neumann, M. Cisse, J.A. Quinn. Continental-scale building
    detection from high resolution satellite imagery.
    [arXiv:2107.12283](https://arxiv.org/abs/2107.12283), 2021.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
