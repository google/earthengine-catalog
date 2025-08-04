var dataset = ee.ImageCollection('COPERNICUS/MARINE/SATELLITE_OCEAN_COLOR/V6')
                  .filter(ee.Filter.date('2024-06-01', '2024-07-01'));
var temp = dataset.select('chlor_a').mean();
var tempVis = {
  min: 0,
  max: 1,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};

var lon = -37.26;
var lat = 43.41;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 2);
Map.addLayer(temp, tempVis, 'chlor_a');

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = temp.visualize(tempVis);
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};


print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));