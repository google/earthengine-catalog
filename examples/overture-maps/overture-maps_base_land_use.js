var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.land_use');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.45, -73.7, 41.05]);
var filtered = dataset.filterBounds(geometry);

// Display the land use features
Map.setCenter(-74.0, 40.75, 10);
Map.addLayer(filtered, {color: '8bc34a'}, 'Overture Maps Land Use');
