var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.land');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the land features
Map.setCenter(-74.006, 40.7128, 10);
Map.addLayer(filtered, {color: '558b2f'}, 'Overture Maps Land');
