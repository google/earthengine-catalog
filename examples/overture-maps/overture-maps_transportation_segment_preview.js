var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.segment');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.02, 40.7, -73.97, 40.75]);
var filtered = dataset.filterBounds(geometry);

// Display the segment features
Map.setCenter(-74.006, 40.7128, 14);
Map.addLayer(filtered, {color: '0277bd'}, 'Overture Maps Transportation Segments');
