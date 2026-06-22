var dataset = ee.FeatureCollection.loadBigQueryTable(
    'bigquery-public-data.overture_maps.bathymetry');

// Filter to a specific area (Florida and Bahamas shallow waters)
var geometry = ee.Geometry.Rectangle([-82, 22, -76, 27]);
var filtered = dataset.filterBounds(geometry);

// Display the bathymetry features
Map.setCenter(-79, 25, 7);
Map.addLayer(filtered, {color: '0288d1'}, 'Overture Maps Bathymetry');
