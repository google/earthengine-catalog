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

    Overture data is accessible in Google BigQuery as part of the Google
    Cloud Public Dataset Program, with the data being listed and maintained
    by CARTO.

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
    'places',
    'poi',
    'points_of_interest',
    'businesses',
    'landmarks',
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
        name: 'geoid',
        description: |||
          A feature ID. This may be an ID associated with the Global Entity
          Reference System (GERS).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'bbox',
        description: |||
          Bounding box defined by two longitudes and two latitudes.
          RECORD type with fields: xmin, xmax, ymin, ymax.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'names',
        description: |||
          The names used when referring to a feature. The first entry must
          have language of 'local'. RECORD type with nested name entries.
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
        name: 'sources',
        description: |||
          Array of source information for properties of a given feature,
          listing property in JSON Pointer notation. RECORD type.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'categories',
        description: |||
          The categories of the place. Complete list available on GitHub.
          RECORD type with primary and alternate categories.
        |||,
        type: ee_const.var_type.string,
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
        name: 'websites',
        description: 'The websites of the place. RECORD type.',
        type: ee_const.var_type.string,
      },
      {
        name: 'socials',
        description: 'The social media URLs of the place. RECORD type.',
        type: ee_const.var_type.string,
      },
      {
        name: 'emails',
        description: 'The email addresses of the place. RECORD type.',
        type: ee_const.var_type.string,
      },
      {
        name: 'phones',
        description: 'The phone numbers of the place. RECORD type.',
        type: ee_const.var_type.string,
      },
      {
        name: 'brand',
        description: |||
          The brand of the place. Locations with multiple brands are
          considered as separate places. RECORD type.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'addresses',
        description: 'The addresses of the place. RECORD type.',
        type: ee_const.var_type.string,
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
        name: 'geometry',
        description: 'Point geometry in WGS84 (EPSG:4326).',
        type: ee_const.var_type.geometry,
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
