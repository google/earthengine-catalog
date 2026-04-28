var image = ee.Image('ESA/CCI/Above_Ground_Biomass/V6_0/2020');
var agb = image.select('agb');

var visParams = {
  min: 0,
  max: 500,
  palette: ['white', 'green'],
};

// Add background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var agb_viz = agb.visualize(visParams);

var lon = -60;
var lat = -3;

// Degrees in EPSG:4326.
var lat_delta = 15;
var lon_delta = 25;

// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var imageWithBackground = ee.ImageCollection([waterLandBackground, agb_viz]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.addLayer(agb_viz, {}, 'Above Ground Biomass 2020');
Map.setCenter(-60, -3, 4);
