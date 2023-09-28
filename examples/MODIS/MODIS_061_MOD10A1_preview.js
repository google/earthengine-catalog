var dataset = ee.ImageCollection('MODIS/061/MOD10A1')
                  .filter(ee.Filter.date('2018-04-01', '2018-05-01'));
var snowCover = dataset.select('NDSI_Snow_Cover').mean();
var snowCoverVis = {
  min: 0.0,
  max: 100.0,
  palette: ['000000', '0dffff', '0524ff', 'ffffff'],
};

var lon = 82;
var lat = 30;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(snowCover, snowCoverVis, 'Snow Cover');

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

var image = snowCover.visualize(snowCoverVis);
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
