// Overture Maps - Buildings: Building
// BigQuery table: bigquery-public-data.overture_maps.building

local id = 'overture-maps/buildings_building';
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
  title: 'Overture Maps - Buildings: Building',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.building',
  description: |||
    The Overture Maps Buildings theme Building layer contains polygon features
    representing structures with roofs that exist permanently in one place.
    Building footprints or roofprints are represented as Polygon or
    MultiPolygon geometries.

    Each building feature includes a subtype (broad category such as
    residential, commercial, industrial) and a class (specific classification
    such as house, apartments, office, warehouse). Additional properties
    include height, number of floors, and underground floor information.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Building Schema](https://docs.overturemaps.org/schema/reference/buildings/building/)

    BigQuery table: `bigquery-public-data.overture_maps.building`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=building',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'building',
    'global',
    'map',
    'urban',
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
          Detailed building purpose classification. 79 possible values
          including: agricultural, apartments, barn, church, factory, garage,
          hospital, house, office, parking, school, warehouse.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: 'Polygon or MultiPolygon geometry in WGS84 (EPSG:4326).',
        type: ee_const.var_type.geometry,
      },
      {
        name: 'has_parts',
        description: |||
          Boolean indicating whether the building has subdivisions
          (building parts). Stored as true/false.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'height',
        description: 'Building height measurement in meters.',
        type: ee_const.var_type.double,
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
        name: 'is_underground',
        description: |||
          Boolean indicating whether the building is underground. Stored as
          true/false.
        |||,
        type: ee_const.var_type.string,
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
        name: 'num_floors',
        description: 'Total number of floors in the building.',
        type: ee_const.var_type.int,
      },
      {
        name: 'num_floors_underground',
        description: 'Number of floors below ground level.',
        type: ee_const.var_type.int,
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
          Broad building category. Possible values: agricultural, civic,
          commercial, education, entertainment, industrial, medical, military,
          outbuilding, religious, residential, service, transportation.
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
        display_name: 'Overture Maps: Buildings',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 14,
        },
        table_visualization: {
          color: 'ff5722',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
