var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.land_use');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.1, 40.6, -73.9, 40.8]);
var filtered = dataset.filterBounds(geometry);

// Display the land use features
Map.setCenter(-74.006, 40.7128, 12);
Map.addLayer(filtered, {color: '8bc34a'}, 'Overture Maps Land Use');
