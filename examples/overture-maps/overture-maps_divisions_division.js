var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.division');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the division features
Map.setCenter(-74.006, 40.7128, 8);
Map.addLayer(filtered, {color: '9c27b0'}, 'Overture Maps Divisions');
