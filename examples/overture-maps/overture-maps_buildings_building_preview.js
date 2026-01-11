var dataset = ee.FeatureCollection(
    'bigquery-public-data.overture_maps.building');

// Filter to a specific area (New York City area)
var geometry = ee.Geometry.Rectangle([-74.02, 40.7, -73.97, 40.75]);
var filtered = dataset.filterBounds(geometry);

// Display the building features
Map.setCenter(-74.006, 40.7128, 14);
Map.addLayer(filtered, {color: 'ff5722'}, 'Overture Maps Buildings');
