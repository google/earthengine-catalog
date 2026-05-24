// Define the data variable for CGMD-Extent30
var dataset = ee.FeatureCollection('projects/mangrovedatahub2/assets/CGMD-Extent30');

// Define the year for visualization
var year = 2023;

// Load the extent layer for the year 2023
var extent = dataset.filter(ee.Filter.eq('year', year));

// Center the map on the image with a zoom level of 8 (covers Bintuni Bay, Indonesia)
Map.setCenter(133.3826, -2.3649, 8);

// Add the layer to the map
Map.addLayer(extent, {color: '006400'}, 'Mangrove extent, ' + year);
