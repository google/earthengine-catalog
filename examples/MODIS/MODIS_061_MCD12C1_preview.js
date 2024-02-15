var dataset = ee.ImageCollection('MODIS/061/MCD12C1');
var igbpLandCover = dataset.select('Majority_Land_Cover_Type_1').median();
var igbpLandCoverVis = {
  min: 0,
  max: 16,
  palette: [
    '1c0dff', '05450a', '086a10', '54a708', '78d203', '009900', 'c6b044', 'dcd159',
    'dade48', 'fbff13', 'b6ff05', '27ff87', 'c24f44', 'a5a5a5', 'ff6d4c',
    '69fff8', 'f9ffa4'
  ],
};

var lon = 87;
var lat = 24;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 16});
Map.setCenter(lon, lat, 2);
Map.addLayer(igbpLandCover, igbpLandCoverVis, 'IGBP Land Cover');

// Degrees in EPSG:4160.
var delta = 20;
// Width and height of the thumbnail image.
var pixels = 256;

var image = igbpLandCover.visualize(igbpLandCoverVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4160',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
