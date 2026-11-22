var visParams = {
  min: 0.0,
  max: 0.5,
  bands: ['soilMoisture'],
  palette: ['0300ff', '418504', 'efff07', 'ff0303']
};

// thumbnail location
var lon = 140.0;
var lat = 35.5;

// Water/land background
var background = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0)
    .visualize({palette: ['cadetblue', 'lightgray']});

var delta = 3;
var pixels = 256;

var collection = ee.ImageCollection('NASA/NISAR/L3_SME2')
    .filterDate('2025-11-24', '2025-11-30')
    .filter(ee.Filter.eq('status', 'provisional'));
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
Map.addLayer(imageWithBackground, {}, 'NISAR Soil Moisture V1');
