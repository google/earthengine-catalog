// Overture Maps - Buildings: Building Part
// BigQuery table: bigquery-public-data.overture_maps.building_part

local id = 'overture-maps/buildings_building_part';
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
  title: 'Overture Maps - Buildings: Building Part',
  version: 'latest',
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'bigquery-public-data.overture_maps.building_part',
  description: |||
    The Overture Maps Buildings theme Building Part layer contains polygon
    features representing individual components or subdivisions of buildings.
    Building parts allow for detailed 3D representation of complex structures
    with varying heights, roof shapes, and floor levels.

    Each building part references its parent building via building_id and
    includes geometric and structural properties such as height, number of
    floors, roof shape, and roof orientation.

    This dataset is part of the Overture Maps Foundation's collaborative
    effort to develop interoperable open map data. The data is released
    monthly and always reflects the most recent release.

    Data source: [Overture Maps Foundation](https://overturemaps.org/)

    Documentation: [Building Part Schema](https://docs.overturemaps.org/schema/reference/buildings/building_part/)

    BigQuery table: `bigquery-public-data.overture_maps.building_part`
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/bigquery?p=bigquery-public-data&d=overture_maps&t=building_part',
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
        name: 'building_id',
        description: 'The building ID to which this part belongs.',
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: 'Polygon or MultiPolygon geometry in WGS84 (EPSG:4326).',
        type: ee_const.var_type.geometry,
      },
      {
        name: 'height',
        description: 'Building part height measurement in meters.',
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
        name: 'min_height',
        description: 'Minimum height value of the building part in meters.',
        type: ee_const.var_type.double,
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
        description: 'Number of floors in this building part.',
        type: ee_const.var_type.int,
      },
      {
        name: 'roof_direction',
        description: 'Directional bearing of the roof in degrees.',
        type: ee_const.var_type.double,
      },
      {
        name: 'roof_height',
        description: 'Roof height measurement in meters.',
        type: ee_const.var_type.double,
      },
      {
        name: 'roof_orientation',
        description: 'Directional orientation of the roof.',
        type: ee_const.var_type.string,
      },
      {
        name: 'roof_shape',
        description: 'Roof configuration type (e.g., flat, gabled, hipped).',
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
        display_name: 'Overture Maps: Building Parts',
        lookat: {
          lat: 40.7128,
          lon: -74.006,
          zoom: 16,
        },
        table_visualization: {
          color: 'e64a19',
          point_size: 2,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:unusual_terms_of_use': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
