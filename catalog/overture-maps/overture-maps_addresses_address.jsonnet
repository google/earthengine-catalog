// Overture Maps - Addresses: Address
// BigQuery table: bigquery-public-data.overture_maps.address

local id = 'overture-maps/addresses_address';
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
  title: 'Overture Maps - Addresses: Address',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.address',
  description: |||
    The Overture Maps Addresses theme contains address point data representing
    physical locations with structured address information. Each address record
    includes geographic coordinates and detailed address components such as
    street name, house number, unit, postcode, and administrative levels.

    Address data is essential for geocoding, navigation, delivery services,
    and location-based applications. The addresses are sourced from
    authoritative open data sources and community contributions.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Addresses Theme Schema](https://docs.overturemaps.org/schema/reference/addresses/address/)

    BigQuery table: `bigquery-public-data.overture_maps.address`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=address',
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
        name: 'address_levels',
        description: |||
          Administrative divisions for the address, ordered from highest to
          lowest level. Array of records containing value (the name of the
          administrative level, e.g., state, municipality, neighborhood).
          Typically contains 1-5 items.
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
        name: 'country',
        description: |||
          The country code for the address in ISO 3166-1 Alpha-2 format
          (e.g., "US", "DE", "JP").
        |||,
        type: ee_const.var_type.string,
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
        name: 'number',
        description: |||
          The house number for the address. May contain non-numeric characters
          such as "74B", "189 1/2", or other locale-specific formats.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'postal_city',
        description: |||
          The city name used for mailing purposes when it differs from the
          actual city where the address is located.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'postcode',
        description: 'The postal code or ZIP code for the address.',
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
        name: 'street',
        description: |||
          The street name associated with this address. Generally spelled out
          fully, though common abbreviations may be used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'unit',
        description: |||
          The unit, suite, apartment, or floor designation for the address.
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
        display_name: 'Overture Maps: Addresses',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 14,
        },
        table_visualization: {
          color: '00897b',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}