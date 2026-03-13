var dataset = ee.ImageCollection('projects/openet/assets/ensemble/conus/gridmet/monthly/v2_1')
  .filterDate('2024-01-01', '2025-01-01');

// Compute the annual evapotranspiration (ET) as the sum of the monthly ET
// images for the year.
var et = dataset.select('et_ensemble_mad').sum();

var visParams = {
  min: 0,
  max: 1000,
  palette: [
    '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b', '9fcb51',
    '80c256', '61b95c', '42b062', '45b677', '49bc8d', '4dc2a2', '51c8b8',
    '55cece', '4db4ba', '459aa7', '3d8094', '356681', '2d4c6e',
  ],
};

var rgbImage = et.visualize(visParams);
Map.addLayer(et, {}, 'OpenET Ensemble Annual ET', true, 0.3);

var lon = -116.47;
var lat = 40.83;
Map.setCenter(lon, lat, 10);

// Degrees in EPSG:3857
var lonDelta = 0.1;
var latDelta = 0.085;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
  null, false);

Map.addLayer(areaOfInterest, {}, 'Area of Interest', true, 0.3);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: rgbImage, params: imageParams}));
