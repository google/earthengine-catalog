// Define the data variable for CGMD-AFCC30
var dataset = ee.ImageCollection('projects/mangrovedatahub2/assets/CGMD-AFCC30');

// Define the year for visualization
var year = 2023;

// Load the fractional canopy cover image for the year 2023
var fcc = dataset
  .filter(ee.Filter.eq('year', year))
  .mosaic();

// Define visualization parameters
var vis = {
  min: 0,
  max: 100,
  palette: ['ffffff', 'd9f0a3', '78c679', '238443', '005a32']
};

// Center the map on the image with a zoom level of 8 (covers Bintuni Bay, Indonesia)
Map.setCenter(133.3826, -2.3649, 8);

// Add the layer to the map
Map.addLayer(fcc, vis, 'Mangrove fractional canopy cover, ' + year);
