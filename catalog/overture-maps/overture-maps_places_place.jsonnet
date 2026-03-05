// Overture Maps - Places: Place
// BigQuery table: bigquery-public-data.overture_maps.place

local id = 'overture-maps/places_place';
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
  title: 'Overture Maps - Places: Place',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.place',
  description: |||
    The Overture Maps Places theme contains more than 64 million point
    representations of real-world entities: businesses, schools, hospitals,
    religious organizations, landmarks, mountain peaks, and much more.

    Each place record includes location coordinates, names, categories,
    contact information (websites, social media, emails, phones), brand
    information, addresses, and operating status. A confidence score
    indicates the certainty of each place's existence.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Places Theme Guide](https://docs.overturemaps.org/guides/places/)

    BigQuery table: `bigquery-public-data.overture_maps.place`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=place',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'global',
    'map',
    'population',
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
        name: 'addresses',
        description: |||
          The addresses of the place. Array of address records, each containing:
          freeform (street address text), locality (city/town name), postcode,
          region (administrative region code, e.g., "US-NY"), and country
          (ISO country code, e.g., "US").
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
        name: 'brand',
        description: |||
          The brand of the place. Record containing: names (brand name
          container with primary and common names) and wikidata (Wikidata
          identifier for the brand). Places with multiple brands are
          represented as separate place entries.
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'categories',
        description: |||
          The categories of the place. Record containing: primary (the main
          category of the place) and alternate (array of additional applicable
          categories). Complete list available on
          [GitHub](https://github.com/OvertureMaps/schema/blob/main/docs/schema/concepts/by-theme/places/overture_categories.csv).
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'confidence',
        description: |||
          The confidence of the existence of the place. A number between 0
          and 1, where higher values indicate greater certainty.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'emails',
        description: |||
          The email addresses associated with the place. Array of records
          containing email address strings.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'geometry',
        description: 'Point geometry in WGS84 (EPSG:4326).',
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
        name: 'names',
        description: |||
          The names of the place. Record containing: primary (main name),
          common (translations by language code, e.g., "es" for Spanish),
          and rules (array of naming variants such as short forms or
          abbreviations).
        |||,
        type: ee_const.var_type.record,
      },
      {
        name: 'operating_status',
        description: |||
          Indicates operating status of a place. Possible values: 'open',
          'permanently_closed', or 'temporarily_closed'.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'phones',
        description: |||
          The phone numbers associated with the place. Array of records
          containing phone number strings.
        |||,
        type: ee_const.var_type.record_list,
      },
      {
        name: 'socials',
        description: |||
          The social media profiles of the place. Array of records containing
          URLs to social media pages.
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
        name: 'version',
        description: |||
          Version number of the feature, incremented in each Overture release
          where geometry or attributes changed.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'websites',
        description: |||
          The websites associated with the place. Array of records containing
          URLs to the place's websites.
        |||,
        type: ee_const.var_type.record_list,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Overture Places',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 12,
        },
        table_visualization: {
          color: '4285f4',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
