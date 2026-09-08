// Overture Maps - Base: Bathymetry
// BigQuery table: bigquery-public-data.overture_maps.bathymetry

local id = 'overture-maps/base_bathymetry';
local subdir = 'overture-maps';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.odbl_1_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Overture Maps - Base: Bathymetry',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.bathymetry',
  description: |||
    The Overture Maps Base theme Bathymetry layer contains polygon features
    representing topographic representations of underwater areas with depth
    information.

    Each bathymetry feature includes a depth value indicating the underwater
    depth and cartography properties for display rendering including zoom
    levels and sort keys.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Bathymetry Schema](https://docs.overturemaps.org/schema/reference/base/bathymetry/)

    BigQuery table: `bigquery-public-data.overture_maps.bathymetry`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=bathymetry',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'bathymetry',
    'global',
    'map',
    'water',
  ],
  providers: [
    ee.producer_provider(
      'Overture Maps Foundation',
      'https://overturemaps.org/'
    ),
    ee.processor_provider(
      'CARTO',
      'https://carto.com/'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2023-07-01T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'bbox',
        description: |||
          Bounding box of the feature geometry. Record with fields: xmin
          (minimum longitude), xmax (maximum longitude), ymin (minimum
          latitude), ymax (maximum latitude).
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'cartography',
        description: |||
          Display properties for cartographic rendering. Record containing:
          min_zoom (minimum zoom level for display, 0-23), max_zoom (maximum
          zoom level for display, 0-23), and sort_key (rendering priority).
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'depth',
        description: |||
          Topographic representation of underwater depth. Negative values
          indicate depth below sea level.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'geometry',
        description: 'Polygon or MultiPolygon geometry in WGS84 (EPSG:4326).',
        type: ee_const.var_type.geometry,
      },
      {
        name: 'id',
        description: |||
          A feature ID. This may be an ID associated with the Global Entity
          Reference System (GERS).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'sources',
        description: |||
          Source attribution for the feature properties. Array of records,
          each containing: property (property name in JSON Pointer notation),
          dataset (source dataset name), and record_id (identifier in the
          source dataset).
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'version',
        description: |||
          Version number of the feature, incremented in each Overture release
          where geometry or attributes changed.
        |||,
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Overture Maps: Bathymetry',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 8,
        },
        table_visualization: {
          color: '0d47a1',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
