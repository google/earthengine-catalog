var dataset = ee.ImageCollection('MODIS/062/MCD18C2')
                  .filter(ee.Filter.date('2001-01-01', '2001-02-01'));
var gmt_1200_par = dataset.select('GMT_1200_PAR').mean();

var gmt_1200_par_vis = {
  min: -236,
  max: 316,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var lon = 32.25;
var lat = 27.37;
Map.setCenter(lon, lat, 2);
Map.addLayer(gmt_1200_par, gmt_1200_par_vis, 'Total PAR at GMT 12:00');

var delta = 40;
var pixels = 256;

var image = gmt_1200_par.visualize(gmt_1200_par_vis);
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
