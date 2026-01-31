var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.building_part');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.02, 40.7, -73.97, 40.75]);
var filtered = dataset.filterBounds(geometry);

// Display the building part features
Map.setCenter(-74.006, 40.7128, 16);
Map.addLayer(filtered, {color: 'e64a19'}, 'Overture Maps Building Parts');
