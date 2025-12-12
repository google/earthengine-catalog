// Load the Overture Maps Places collection using the BigQuery connector.
var places = ee.FeatureCollection.loadBigQueryTable(
  'bigquery-public-data.overture_maps.place'
);

// Center the map on New York City.
Map.setCenter(-74.006, 40.7128, 12);

// Filter to show places in a specific area (Manhattan).
var manhattan = ee.Geometry.Rectangle([-74.02, 40.7, -73.97, 40.78]);
var manhattanPlaces = places.filterBounds(manhattan);

// Add the places layer to the map.
Map.addLayer(manhattanPlaces, {color: '4285f4'}, 'Overture Places');
