var dataset = ee.ImageCollection('NASA/GEOS-CF/v2/ana/tavg1hr')
                  .filter(ee.Filter.date('2025-08-04', '2025-08-11'));
var NO2 = dataset.select('NO2').median();
var NO2Vis = {
  min: 1e-10,
  max: 1e-9,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};

var lon = -20;
var lat = 0;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 2);
Map.addLayer(NO2, NO2Vis, 'NO2');

// Degrees in EPSG:3857.
var delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;

var image = NO2.visualize(NO2Vis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};


print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
