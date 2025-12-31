var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.division_area');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the division area features
Map.setCenter(-74.006, 40.7128, 6);
Map.addLayer(filtered, {color: '7b1fa2'}, 'Overture Maps Division Areas');
