var visParams = {
  min: 0.0,
  max: 0.5,
  bands: ['soilMoisture'],
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303']
};

// thumbnail location
var lon = 140.0;
var lat = 35.5;

// Background
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var delta = 3;
var pixels = 256;

var collection = ee.ImageCollection('NASA/NISAR/L3_SME2_BETA_V1')
    .filterDate('2025-10-17', '2025-10-25');
var image = collection.mosaic().visualize(visParams);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Specify the thumbnail parameters.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
Map.setCenter(lon, lat, 6);
Map.addLayer(imageWithBackground, {}, 'NISAR Soil Moisture Beta V1');

