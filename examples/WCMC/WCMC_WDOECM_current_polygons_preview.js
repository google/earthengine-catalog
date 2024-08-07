// Define the area of interest (AOI)
var lon = -88.6;
var lat = 26.4;
var delta = 50;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Load the WDPA dataset (polygons)
var wdpa = ee.FeatureCollection("WCMC/WDOECM/202407/polygons");

// Set visualization parameters for WDPA polygons
var wdpaVis = {
  color: '33fcff', // Light cyan color for the polygons
  width: 1,
  fillColor: '33fcff'
};

// Style and clip the WDPA polygons to the AOI
var styledWdpa = wdpa.style(wdpaVis).clip(areaOfInterest);

// Create a global white image
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
    [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
    .visualize({palette: ['ffffff'], min: 0, max: 1});

var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);
var landCover = ee.Image('MODIS/006/MCD12Q1/2019_01_01').select('LC_Type1');

var landCoverVis = {
  min: 0,
  max: 17,
  palette: [
    '000000', '006400'
  ]
};

var landCoverImage = landCover.visualize(landCoverVis).clip(areaOfInterest);

// Blend the clipped white image with the clipped MODIS land cover image
var blendedLayer = clippedWhiteImage.blend(landCoverImage).blend(styledWdpa);

// Add the layers to the map
Map.setCenter(lon, lat, 5);
Map.addLayer(blendedLayer, {}, 'Blended Layers with WDPA Polygons and MODIS Land Cover');

// Define parameters for the thumbnail image
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the thumbnail of the blended layer
print(ui.Thumbnail({image: blendedLayer, params: visParams}));
