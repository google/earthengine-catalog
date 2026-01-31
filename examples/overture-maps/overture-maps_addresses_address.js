var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.address');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.1, 40.6, -73.9, 40.8]);
var filtered = dataset.filterBounds(geometry);

// Display the addresses
Map.setCenter(-74.006, 40.7128, 14);
Map.addLayer(filtered, {color: '00897b'}, 'Overture Maps Addresses');
