local id = 'overture-maps';
local ee_const = import 'earthengine_const.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'overture-maps/';

{
  'stac_version': ee_const.stac_version,
  'type': 'Catalog',
  'id': id,
  'title': 'Overture Maps',
  'description': |||
    Overture Maps Foundation is a collaborative effort to develop
    interoperable open map data. The foundation produces open map data
    containing nearly 4.2 billion features organized into six themes:
    Addresses, Base, Buildings, Divisions, Places, and Transportation.

    The data is released monthly and is available as cloud-native GeoParquet
    files. Overture data is accessible in Google BigQuery as part of the
    Google Cloud Public Dataset Program, with the data being listed and
    maintained by CARTO.
  |||,
  'links': [
    ee_const.link.root,
    ee_const.link.parent,
    ee_const.link.self_link(base_url, base_filename),
    // Addresses theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Addresses',
      'href': base_url + 'overture-maps_addresses_address.json',
      'type': 'application/json',
    },
    // Base theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Bathymetry',
      'href': base_url + 'overture-maps_base_bathymetry.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Infrastructure',
      'href': base_url + 'overture-maps_base_infrastructure.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Land',
      'href': base_url + 'overture-maps_base_land.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Land Cover',
      'href': base_url + 'overture-maps_base_land_cover.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Land Use',
      'href': base_url + 'overture-maps_base_land_use.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Base: Water',
      'href': base_url + 'overture-maps_base_water.json',
      'type': 'application/json',
    },
    // Buildings theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Buildings: Building',
      'href': base_url + 'overture-maps_buildings_building.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Buildings: Building Part',
      'href': base_url + 'overture-maps_buildings_building_part.json',
      'type': 'application/json',
    },
    // Divisions theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Divisions: Division',
      'href': base_url + 'overture-maps_divisions_division.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Divisions: Division Area',
      'href': base_url + 'overture-maps_divisions_division_area.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Divisions: Division Boundary',
      'href': base_url + 'overture-maps_divisions_division_boundary.json',
      'type': 'application/json',
    },
    // Places theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Places: Place',
      'href': base_url + 'overture-maps_places_place.json',
      'type': 'application/json',
    },
    // Transportation theme
    {
      'rel': 'child',
      'title': 'Overture Maps - Transportation: Segment',
      'href': base_url + 'overture-maps_transportation_segment.json',
      'type': 'application/json',
    },
    {
      'rel': 'child',
      'title': 'Overture Maps - Transportation: Connector',
      'href': base_url + 'overture-maps_transportation_connector.json',
      'type': 'application/json',
    },
  ],
}
