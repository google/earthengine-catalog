var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.water');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the water features
Map.setCenter(-74.006, 40.7128, 10);
Map.addLayer(filtered, {color: '1565c0'}, 'Overture Maps Water');
