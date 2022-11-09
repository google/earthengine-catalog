local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local versions = import 'versions.libsonnet';
local version_table = import 'GOOGLE_Geo_buildings-plus_polygons.libsonnet';

local subdir = 'GOOGLE';

local version = 'v1.0';
local version_config = versions(subdir, version_table, version);

local license = spdx.cc_by_4_0;
{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: version_config.id,
  title: 'Buildings Plus V1 Polygons',
  version: '1.0.0',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This dataset consists of outlines of buildings derived from convolutional
    models applied to high-resolution airborne imagery. It contains ~170
    million building footprints in the United States.

    Buildings in this dataset include a polygon describing its
    footprint on the ground, an estimated building height in meters and an
    an estimated building type.  The shape, location, height and/or type of
    buildings in the dataset are the results of best estimates from ML models,
    which may be of varying accuracy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, version_config.id) + [
    ee.link.license(license.reference)
  ] + version_config.version_links,
  keywords: [
    'building',
    'buildings',
    'urban'
  ],
  providers: [
    ee.producer_provider('Google Geo', 'https://mapsplatform.google.com/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2021-06-01T00:00:00Z', '2021-06-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'area_m',
        description: 'Area in square meters of the polygon.',
        type: ee_const.var_type.double,
        units: 'm^2',
      },
      {
        name: 'height_m',
        description: 'Estimated height to centroid of upper building goemetry.',
        type: ee_const.var_type.double,
      },
      {
        name: 'type',
        description: 'Estimated type/use of the building.',
        type: ee_const.var_type.string,
      },
      {
        name: 'place_id',
        description: 'Unique identifier for each building.',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Google Geo Buildings V1',
        lookat: {
          lat: 37.42493,
          lon: -122.09412,
          zoom: 17,
        },
        table_visualization: {
          color: 'ffffffff',
          fill_color: 'ffffff88',
        },
      },
      {
        display_name: 'Google Geo Buildings V1',
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
    [Google Geo](https://mapsplatform.google.com/), 2022.
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': false,
}
