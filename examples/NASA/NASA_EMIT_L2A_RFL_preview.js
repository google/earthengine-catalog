var dataset = ee.ImageCollection('NASA/EMIT/L2A/RFL')
                  .filter(ee.Filter.date('2022-01-01', '2023-12-01'));
var emitRef = dataset.select('reflectance_1').mean();
var emitRefVis = {
  min: 0,
  max: 0.1,
  palette: ['d7191c', 'fdae61'],
};


var lon = -113.024;
var lat = 27.411;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 6);

// Degrees in EPSG:3857.
var delta = 8;
// Width and height of the thumbnail image.
var pixels = 256;

var image = emitRef.visualize(emitRefVis);
var imageWithBackground = ee.ImageCollection([waterLandBackground, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, null, 'Emit Reflectance');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
