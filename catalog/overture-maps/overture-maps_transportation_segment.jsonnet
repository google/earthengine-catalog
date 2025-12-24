// Overture Maps - Transportation: Segment
// BigQuery table: bigquery-public-data.overture_maps.segment

local id = 'overture-maps/transportation_segment';
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
  title: 'Overture Maps - Transportation: Segment',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.segment',
  description: |||
    The Overture Maps Transportation theme Segment layer contains LineString
    features representing paths of travel or surfaces for transportation.
    Segments include roads, highways, footpaths, cycleways, railways, and
    other transportation infrastructure.

    Each segment feature includes detailed properties such as subtype (road,
    rail, water), class (specific road type like motorway, primary,
    residential), surface material, speed limits, access restrictions, lane
    information, and references to connector nodes at each end.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Segment Schema](https://docs.overturemaps.org/schema/reference/transportation/segment/)

    BigQuery table: `bigquery-public-data.overture_maps.segment`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=segment',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'global',
    'infrastructure',
    'map',
    'roads',
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
        name: 'access_restrictions',
        description: |||
          Access restriction rules for the segment. Array of records
          containing restriction type and applicable conditions.
        |||,
        type: ee_const.var_type.record_list,
      },
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
          Specific segment classification. Possible values for roads include:
          motorway, trunk, primary, secondary, tertiary, residential,
          living_street, service, pedestrian, footway, cycleway, bridleway,
          steps, path, track, unknown.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'connector_ids',
        description: |||
          Array of connector IDs at the endpoints of this segment. Typically
          contains two IDs representing the start and end connectors.
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'destinations',
        description: |||
          Destination sign information. Array of records containing
          destination labels and directional information.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'geometry',
        description: |||
          LineString geometry in WGS84 (EPSG:4326) representing the path
          of the transportation segment.
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
        name: 'lanes',
        description: |||
          Lane information for the segment. Array of records containing
          lane direction, access rules, and turn restrictions.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'level',
        description: |||
          Vertical level of the segment relative to ground. 0 is ground
          level, positive values are above ground, negative below.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'level_rules',
        description: |||
          Rules for vertical level changes along the segment. Array of
          records containing level values and position ranges.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'names',
        description: |||
          The names of the feature. Record containing: primary (main name),
          common (translations by language code, e.g., "es" for Spanish),
          and rules (array of naming variants such as short forms or
          abbreviations).
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'prohibited_transitions',
        description: |||
          Turn restrictions at connectors. Array of records specifying
          prohibited movements and applicable conditions.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'road_flags',
        description: |||
          Boolean flags for road properties. Array of strings indicating
          features like is_bridge, is_tunnel, is_link, is_under_construction.
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'road_surface',
        description: |||
          Surface properties of the road. Array of records containing
          surface type and condition information.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'routes',
        description: |||
          Route designations that include this segment. Array of records
          containing route names, references, and network information.
        |||,
        type: ee_const.var_type.record_list,
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
        name: 'speed_limits',
        description: |||
          Speed limit information. Array of records containing speed values,
          units, and applicable conditions (e.g., by time or vehicle type).
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'subtype',
        description: |||
          Broad segment category. Possible values: road, rail, water.
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
      {
        name: 'width_rules',
        description: |||
          Width specifications for the segment. Array of records containing
          width values and position ranges.
        |||,
        type: ee_const.var_type.record_list,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Overture Maps: Transportation Segments',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 14,
        },
        table_visualization: {
          color: '0277bd',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
