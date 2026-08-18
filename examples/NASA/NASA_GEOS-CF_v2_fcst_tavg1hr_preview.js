var dataset = ee.ImageCollection('NASA/GEOS-CF/v2/fcst/tavg1hr')
                  .filter(ee.Filter.date('2025-08-04', '2025-08-11'));
var NO2 = dataset.select('NO2').median();
var NO2Vis = {
  min: 1e-10,
  max: 1e-9,
  palette: ['#d53e4f', '#f46d43', '#fee08b', '#e6f598', '#abdda4', '#3288bd', '#5e4fa2'],
};

// Centered to cover the entire conterminous US
var lon = -98;
var lat = 38;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(NO2, NO2Vis, 'NO2');

// Degrees in EPSG:3857 - Cover conterminous US
var delta = 30;
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
