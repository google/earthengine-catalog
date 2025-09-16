// Define the area of interest (AOI)
var lon = 137;
var lat = 35.36;
var delta = 11;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Create a global white image
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
  [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
  .visualize({palette: ['ffffff'], min: 0, max: 1});

var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);

// Load the JAXA ALOS AW3D30 V4.1 dataset
var dataset = ee.ImageCollection('JAXA/ALOS/AW3D30/V4_1');
var elevation = dataset.select('DSM');

// Reproject an image mosaic using a projection from one of the image tiles
// to ensure consistent calculation.
var proj = elevation.first().select('DSM').projection();

// Define visualization parameters for the DSM (elevation)
var elevationVisParams = {
  min: 0,
  max: 2500, // Typical max elevation for AW3D30 visualization
  palette: ['000000', 'FFFFFF'] // Grayscale palette
};

var elevationRGB = elevation.mosaic().setDefaultProjection(proj).visualize(elevationVisParams);
// Mask out 0 values in the visualized elevation
elevationRGB = elevationRGB.updateMask(elevationRGB.neq(0));

// Blend the clipped white image with the clipped elevationRGB image
var elevationRGB = clippedWhiteImage.blend(elevationRGB);

// Set map center and zoom level
Map.setCenter(lon, lat, 11);

// Add elevation layer to the map
Map.addLayer(elevationRGB, {}, 'Elevation');

// Define parameters for the thumbnail image
var pixels = 256; // Width and height of the thumbnail image
var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857', // Web Mercator projection for consistency with EE App
  format: 'png'
};

// Create and print the thumbnail
print(ui.Thumbnail({
  image: elevationRGB,
  params: thumbnailParams
}));