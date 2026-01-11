var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.infrastructure');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the infrastructure features
Map.setCenter(-74.006, 40.7128, 12);
Map.addLayer(filtered, {color: '795548'}, 'Overture Maps Infrastructure');
