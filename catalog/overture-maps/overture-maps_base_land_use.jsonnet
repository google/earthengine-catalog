// Overture Maps - Base: Land Use
// BigQuery table: bigquery-public-data.overture_maps.land_use

local id = 'overture-maps/base_land_use';
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
  title: 'Overture Maps - Base: Land Use',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.land_use',
  description: |||
    The Overture Maps Base theme Land Use layer contains features representing
    classifications of human land usage derived primarily from OpenStreetMap
    features containing the landuse tag.

    Each land use feature includes a subtype (broad category such as
    agriculture, residential, park, military) and a class (specific
    classification such as farmland, forest, hospital, industrial). The data
    supports Point, LineString, Polygon, and MultiPolygon geometries.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Land Use Schema](https://docs.overturemaps.org/schema/reference/base/land_use/)

    BigQuery table: `bigquery-public-data.overture_maps.land_use`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=land_use',
    },
  ],
  'gee:categories': [
    'infrastructure-boundaries',
  ],
  keywords: [
    'global',
    'landcover',
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
          Specific land use classification providing granular categorization.
          Examples include: farmland, forest, hospital, industrial,
          nature_reserve, playground, residential, school, stadium,
          university, zoo, and many others (100+ possible values).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'elevation',
        description: |||
          Height measurement of the land use feature in meters, where
          applicable.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'geometry',
        description: |||
          Geometry in WGS84 (EPSG:4326). Can be Point, LineString, Polygon,
          or MultiPolygon.
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
        name: 'source_tags',
        description: |||
          Original OpenStreetMap tags associated with the feature. Record
          containing key-value pairs from the source OSM data.
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
          Broad land use category. Possible values include: agriculture,
          aquaculture, campground, cemetery, construction, developed,
          education, entertainment, golf, grass, horticulture, landfill,
          managed, medical, military, park, pedestrian, protected,
          recreation, religious, residential, resource_extraction,
          transportation, and winter_sports.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'surface',
        description: |||
          Physical surface material of the land use area (e.g., grass,
          asphalt, gravel).
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
        display_name: 'Overture Maps: Land Use',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 12,
        },
        table_visualization: {
          color: '8bc34a',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
