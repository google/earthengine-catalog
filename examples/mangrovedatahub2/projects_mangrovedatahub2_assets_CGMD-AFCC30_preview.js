var lon = 133.6;
var lat = -2.4;

var delta = 0.5;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
    
var dataset = ee.ImageCollection('projects/mangrovedatahub2/assets/CGMD-AFCC30');

// Load the fractional canopy cover image for the year 2023
var fcc = dataset
  .filter(ee.Filter.eq('year', 2023))
  .mosaic();

// Define visualization parameters
var vis = {
  min: 0,
  max: 100,
  palette: ['ffffff', 'd9f0a3', '78c679', '238443', '005a32']
};

var rgbImage = fcc.visualize(vis);

// Center the map on the image with a zoom level of 8 (covers Bintuni Bay, Indonesia)
Map.setCenter(lon, lat, 8);

// Add the layer to the map
Map.addLayer(rgbImage, {}, 'Mangrove FCC in 2023', true, 1);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, rgbImage]).mosaic();

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));