var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.bathymetry');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.3, 40.4, -73.7, 40.95]);
var filtered = dataset.filterBounds(geometry);

// Display the bathymetry features
Map.setCenter(-74.006, 40.7128, 8);
Map.addLayer(filtered, {color: '0d47a1'}, 'Overture Maps Bathymetry');
