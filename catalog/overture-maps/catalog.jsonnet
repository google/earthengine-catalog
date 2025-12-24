local id = 'overture-maps';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'overture-maps/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: |||
    Overture Maps Foundation is a collaborative effort to develop
    interoperable open map data. The foundation produces open map data
    containing nearly 4.2 billion features organized into six themes:
    Addresses, Base, Buildings, Divisions, Places, and Transportation.

    The data is released monthly and is available as cloud-native GeoParquet
    files. Overture data is accessible in Google BigQuery as part of the
    Google Cloud Public Dataset Program, with the data being listed and
    maintained by CARTO.
  |||,
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),
    ee.link.child_collection('overture-maps_addresses_address', base_url),
    ee.link.child_collection('overture-maps_base_bathymetry', base_url),
    ee.link.child_collection('overture-maps_base_infrastructure', base_url),
    ee.link.child_collection('overture-maps_base_land', base_url),
    ee.link.child_collection('overture-maps_base_land_cover', base_url),
    ee.link.child_collection('overture-maps_base_land_use', base_url),
    ee.link.child_collection('overture-maps_base_water', base_url),
    ee.link.child_collection('overture-maps_buildings_building', base_url),
    ee.link.child_collection('overture-maps_buildings_building_part', base_url),
    ee.link.child_collection('overture-maps_divisions_division', base_url),
    ee.link.child_collection('overture-maps_divisions_division_area', base_url),
    ee.link.child_collection('overture-maps_divisions_division_boundary', base_url),
    ee.link.child_collection('overture-maps_places_place', base_url),
    ee.link.child_collection('overture-maps_transportation_connector', base_url),
    ee.link.child_collection('overture-maps_transportation_segment', base_url),
  ],
}
