// FAO_WAPOR_3_L1_I_D_preview.js
var lon = 17.5;
var lat = 0;
var delta = 37;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var dataset = ee.ImageCollection('FAO/WAPOR/3/L1_I_D').first();
var visParams = {min: 0, max: 5};

var imageToDisplay = dataset.visualize(visParams).clip(areaOfInterest);

// Blend with a white background
var globalWhiteImage = ee.Image(1).paint(ee.Geometry.Polygon(
    [[[-180, -90], [180, -90], [180, 90], [-180, 90]]]), 0)
    .visualize({palette: ['ffffff'], min: 0, max: 1});
var clippedWhiteImage = globalWhiteImage.clip(areaOfInterest);
var blendedLayer = clippedWhiteImage.blend(imageToDisplay);
Map.addLayer(blendedLayer, {}, 'L1_I_D Preview');

Map.setCenter(lon, lat, 4);

var thumbParams = {
  dimensions: [256, 256],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({
  image: blendedLayer,
  params: thumbParams,
}));