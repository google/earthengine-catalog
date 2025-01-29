var dataset = ee.ImageCollection('MODIS/061/MOD10A2')
                  .filter(ee.Filter.date('2023-01-01', '2023-12-01'));

var snowExtent = dataset.select('Maximum_Snow_Extent').mosaic();

var snowExtentVis = {
  min: 40.0,
  max: 200.0,
  palette: [
    '000000',
    '0dffff',
    '0524ff',
    'ffffff'
  ],
};

var lon = 40.52;
var lat = 50.98;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var delta = 10;
var pixels = 256;

var image = snowExtent.visualize(snowExtentVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground, {}, 'Maximum Snow Extent');

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
