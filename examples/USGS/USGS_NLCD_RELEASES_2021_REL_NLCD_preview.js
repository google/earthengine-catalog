// Import the NLCD RCMAP TRENDS image.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/NLCD');

// Filter the collection to the 2021 product.
var nlcd2021 = dataset.filter(ee.Filter.eq('system:index', '2021')).first();

// Select to the landcover band
var landcover = nlcd2021.select('landcover');

var lon = -95;
var lat = 36;
Map.setCenter(lon, lat, 5);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Degrees in EPSG:3857.
var delta = 14.5;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var image = landcover.visualize();
Map.addLayer(image)

var imageWithBackground = ee.ImageCollection(
    [waterLandBackground, image]).mosaic();
Map.addLayer(imageWithBackground, null, 'landcover');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
