var dataset = ee.ImageCollection('MODIS/061/MYD16A2')
                  .filter(ee.Filter.date('2021-01-01', '2021-02-01'));
var evapotranspiration = dataset.select('ET').mean();
var evapotranspirationVis = {
  min: 0.0,
  max: 300.0,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};

var lon = 6.746;
var lat = 46.529;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(evapotranspiration, evapotranspirationVis, 'Evapotranspiration');

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = evapotranspiration.visualize(evapotranspirationVis);
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