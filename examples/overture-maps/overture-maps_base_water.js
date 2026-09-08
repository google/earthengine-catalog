var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.water');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.45, -73.7, 41.05]);
var filtered = dataset.filterBounds(geometry);

// Display the water features
Map.setCenter(-74.0, 40.75, 10);
Map.addLayer(filtered, {color: '1565c0'}, 'Overture Maps Water');
