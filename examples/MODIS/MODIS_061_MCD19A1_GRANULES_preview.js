var dataset = ee.ImageCollection('MODIS/061/MCD19A1_GRANULES')
                  .filterDate('2000-01-01', '2000-03-01');
var surRefl = dataset.select('Sur_refl1').mean();
var surReflVis = {
  min: 0.0,
  max: 1100.0,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};

var lon = 77;
var lat = 22;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(surRefl, surReflVis, 'Surface Bidirectional Reflectance Factor');

// Degrees in EPSG:4326.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = surRefl.visualize(surReflVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
