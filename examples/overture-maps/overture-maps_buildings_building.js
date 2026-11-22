var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.building');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.45, -73.7, 41.05]);
var filtered = dataset.filterBounds(geometry);

// Display the building features
Map.setCenter(-74.0, 40.75, 10);
Map.addLayer(filtered, {color: 'ff5722'}, 'Overture Maps Buildings');
