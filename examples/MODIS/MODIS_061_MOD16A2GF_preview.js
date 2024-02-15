var dataset = ee.ImageCollection('MODIS/061/MOD16A2GF')
                  .filter(ee.Filter.date('2022-01-01', '2022-05-01'));
var evapotranspiration = dataset.select('ET').mosaic();
var evapotranspirationVis = {
  min: 0,
  max: 300,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};
var lon = -120;
var lat = 40;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var delta = 5;
// Width and height of the thumbnail image.
var pixels = 256;

var image = evapotranspiration.visualize(evapotranspirationVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.setCenter(lon, lat, 2);
Map.addLayer(imageWithBackground, {}, 'Evapotranspiration');

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
