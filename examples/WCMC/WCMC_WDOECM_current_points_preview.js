// Define the area of interest (AOI) around the new center
var lon = 124.49;
var lat = 11.63;
var delta = 8;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Load the WDPA dataset (points)
var dataset = ee.FeatureCollection('WCMC/WDOECM/202407/points');

var styledPoints = dataset.style({
  color: '0000FF', // Blue color
  pointSize: 2,
});

// Create a global white image
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
    [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
    .visualize({palette: ['ffffff'], min: 0, max: 1});

var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);

// Load the MODIS land cover dataset
var landCover = ee.Image('MODIS/006/MCD12Q1/2019_01_01').select('LC_Type1');

var landCoverVis = {
  min: 0,
  max: 17,
  palette: [
    '000000', '006400', '00ff00', '00ff7f', '7fff00', 'ffff00', 'ff7f00',
    'ff0000', 'ff00ff', 'ff7f7f', '7f7f7f', 'b0b0b0', '8b4513', 'a0522d',
    'd2b48c', 'deb887', 'd3d3d3'
  ]
};

var landCoverImage = landCover.visualize(landCoverVis).clip(areaOfInterest);

// Blend the clipped white image with the clipped MODIS land cover image
var blendedLayer = clippedWhiteImage.blend(landCoverImage).blend(styledPoints);


Map.setCenter(lon, lat, 6);
Map.addLayer(blendedLayer, {}, 'Blended Layers with OECMs Points');

// Define parameters for the thumbnail image
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the thumbnail of the blended layer at zoom level 6
print(ui.Thumbnail({
  image: blendedLayer,
  params: visParams,
}));
