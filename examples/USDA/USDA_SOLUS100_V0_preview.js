var soc = ee.Image('USDA/SOLUS100/V0/soc');
// NOTE: The following is equivalent:
// var soc = ee.ImageCollection('USDA/SOLUS100/V0')
//   .filter(ee.Filter.eq('system:index', 'soc'))
//   .first();
var soc_0_cm_p = soc.select('r_0_cm_p');

var visParams = {
  min: 0,
  max: 2000,
  palette: ['fff7bc', 'fee391', 'fec44f', 'fe9929', 'ec7014', 'cc4c02', '993404'],
};

// Add background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var soc_viz = soc_0_cm_p.visualize(visParams);

var lon = -95;
var lat = 38;

// Degrees in EPSG:4326.
var lat_delta = 25;
var lon_delta = 35;

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

var imageWithBackground = ee.ImageCollection([waterLandBackground, soc_viz]).mosaic();
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.addLayer(soc_viz, {}, 'Soil Organic Carbon 0-5cm');
Map.setCenter(-95, 38, 4);
