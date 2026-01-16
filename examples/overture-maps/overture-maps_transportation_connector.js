var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.connector');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.02, 40.7, -73.97, 40.75]);
var filtered = dataset.filterBounds(geometry);

// Display the connector features
Map.setCenter(-74.006, 40.7128, 14);
Map.addLayer(filtered, {color: '1565c0'}, 'Overture Maps Transportation Connectors');
