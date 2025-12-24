var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.land_cover');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the land cover features
Map.setCenter(-74.006, 40.7128, 10);
Map.addLayer(filtered, {color: '2e7d32'}, 'Overture Maps Land Cover');
