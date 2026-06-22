// Overture Maps - Divisions: Division Boundary
// BigQuery table: bigquery-public-data.overture_maps.division_boundary

local id = 'overture-maps/divisions_division_boundary';
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
  title: 'Overture Maps - Divisions: Division Boundary',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.division_boundary',
  description: |||
    The Overture Maps Divisions theme Division Boundary layer contains
    LineString features representing the shared boundaries between division
    areas. Boundaries are derived from the edges of division area polygons
    where two or more divisions meet.

    Each boundary feature includes information about the divisions on either
    side, the administrative levels involved, and political perspective data
    for disputed boundaries.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Division Boundary Schema](https://docs.overturemaps.org/schema/reference/divisions/division_boundary/)

    BigQuery table: `bigquery-public-data.overture_maps.division_boundary`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=division_boundary',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'boundaries',
    'global',
    'map',
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
        name: 'class',
        description: |||
          Boundary classification based on administrative levels. Possible
          values: country, region, county, localadmin, locality, neighborhood.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: |||
          LineString or MultiLineString geometry in WGS84 (EPSG:4326)
          representing the boundary line between divisions.
        |||,
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
        name: 'perspectives',
        description: |||
          Political perspective information for disputed boundaries. Record
          containing acceptance and dispute information.
        |||,
        type: ee_const.var_type.record,
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
        name: 'subtype',
        description: |||
          Boundary type. Possible values: land, maritime, land_and_maritime.
        |||,
        type: ee_const.var_type.string,
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
        display_name: 'Overture Maps: Division Boundaries',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 6,
        },
        table_visualization: {
          color: '512da8',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
