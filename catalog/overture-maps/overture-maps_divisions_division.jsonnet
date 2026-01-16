// Overture Maps - Divisions: Division
// BigQuery table: bigquery-public-data.overture_maps.division

local id = 'overture-maps/divisions_division';
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
  title: 'Overture Maps - Divisions: Division',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.division',
  description: |||
    The Overture Maps Divisions theme Division layer contains point features
    representing recognized official or non-official organizations of people
    as seen from a given political perspective. Divisions represent
    administrative hierarchies from countries down to neighborhoods.

    Each division feature includes a subtype (administrative level such as
    country, region, county, locality, neighborhood), country and region
    codes, population data, and hierarchical relationships to parent and
    capital divisions.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Division Schema](https://docs.overturemaps.org/schema/reference/divisions/division/)

    BigQuery table: `bigquery-public-data.overture_maps.division`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=division',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'boundaries',
    'global',
    'map',
    'population',
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
        name: 'capital_division_ids',
        description: |||
          Array of division IDs that serve as capitals for this division.
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'capital_of_divisions',
        description: |||
          Array of division IDs for which this division serves as a capital.
        |||,
        type: ee_const.var_type.string_list,
      },
      {
        name: 'class',
        description: 'Settlement classification for the division.',
        type: ee_const.var_type.string,
      },
      {
        name: 'country',
        description: 'ISO 3166-1 alpha-2 country code.',
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: |||
          Point geometry in WGS84 (EPSG:4326) representing the approximate
          location of the division.
        |||,
        type: ee_const.var_type.geometry,
      },
      {
        name: 'hierarchies',
        description: |||
          Administrative hierarchies containing this division. Array of
          records with hierarchy information.
        |||,
        type: ee_const.var_type.record_list,
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
        name: 'local_type',
        description: |||
          Localized name for the subtype. Record containing language-specific
          type names.
        |||,
        type: ee_const.var_type.record,
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
        name: 'norms',
        description: |||
          Local rules and conventions. Record containing properties such as
          driving_side.
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'parent_division_id',
        description: |||
          ID of the parent division. Required for all divisions except
          countries.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'perspectives',
        description: |||
          Political perspective information for disputed divisions. Record
          containing acceptance and dispute information.
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'population',
        description: 'Population count for the division.',
        type: ee_const.var_type.int,
      },
      {
        name: 'region',
        description: 'ISO 3166-2 principal subdivision code.',
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
        name: 'subtype',
        description: |||
          Administrative level. Possible values: country, dependency, region,
          county, localadmin, locality, macrohood, neighborhood, microhood.
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
        name: 'wikidata',
        description: 'Wikidata reference identifier.',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Overture Maps: Divisions',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 8,
        },
        table_visualization: {
          color: '9c27b0',
          point_size: 3,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
