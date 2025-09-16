// FAO_WAPOR_3_L1_I_D_preview.js
var lon = 17.5;
var lat = 0;
var delta = 37;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var dataset = ee.ImageCollection('FAO/WAPOR/3/L1_I_D').first();
var visParams = {min: 0, max: 5};

var imageToDisplay = dataset.visualize(visParams).clip(areaOfInterest);

// Background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var blendedLayer = waterLandBackground.blend(imageToDisplay);


Map.addLayer(blendedLayer, {}, 'L1_I_D Preview');

Map.setCenter(lon, lat, 4);

var pixels = 256;
var thumbParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({
  image: blendedLayer,
  params: thumbParams,
}));