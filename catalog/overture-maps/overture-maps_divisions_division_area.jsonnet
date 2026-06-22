// Overture Maps - Divisions: Division Area
// BigQuery table: bigquery-public-data.overture_maps.division_area

local id = 'overture-maps/divisions_division_area';
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
  title: 'Overture Maps - Divisions: Division Area',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.division_area',
  description: |||
    The Overture Maps Divisions theme Division Area layer contains polygon
    features representing the geometric boundaries of recognized official or
    non-official organizations of people as seen from a given political
    perspective.

    Each division area feature links to its parent division via division_id
    and includes information about its subtype (land or maritime), whether
    it's the main boundary for its division, and political perspective data
    for disputed territories.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Division Area Schema](https://docs.overturemaps.org/schema/reference/divisions/division_area/)

    BigQuery table: `bigquery-public-data.overture_maps.division_area`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=division_area',
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
        name: 'division_id',
        description: |||
          ID of the division to which this area belongs. Required reference
          to the parent division feature.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: |||
          Polygon or MultiPolygon geometry in WGS84 (EPSG:4326) representing
          the geographic extent of the division.
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
        name: 'is_land',
        description: |||
          Boolean indicating whether this is the land area (true) or maritime
          area (false) for the division. Stored as true/false.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'is_main',
        description: |||
          Boolean indicating whether this is the primary/main area for its
          division. Stored as true/false.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'perspectives',
        description: |||
          Political perspective information for disputed areas. Record
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
        description: 'Area type. Possible values: land, maritime.',
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
        display_name: 'Overture Maps: Division Areas',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 6,
        },
        table_visualization: {
          color: '7b1fa2',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
