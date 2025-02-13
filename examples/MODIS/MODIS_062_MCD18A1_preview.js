var dataset = ee.ImageCollection('MODIS/062/MCD18A1')
                  .filter(ee.Filter.date('2001-01-01', '2001-02-01'));
var gmt_1200_dsr = dataset.select('GMT_1200_DSR').mean();

var gmt_1200_dsr_vis = {
  min: 0,
  max: 350,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var lon = 52.26;
var lat = 26.97;
Map.setCenter(lon, lat, 2);
Map.addLayer(gmt_1200_dsr, gmt_1200_dsr_vis, 'Total DSR at GMT 12:00');

var delta = 30;
var pixels = 256;

var image = gmt_1200_dsr.visualize(gmt_1200_dsr_vis);
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
