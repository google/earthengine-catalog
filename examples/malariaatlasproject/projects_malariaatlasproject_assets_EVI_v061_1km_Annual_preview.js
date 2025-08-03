var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/EVI_v061/1km/Annual')
                  .filter(ee.Filter.date('2018-01-01', '2023-01-01'));
var means = dataset.select('Mean');
var palette = ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'];
var visParams = {
  min: 0.0,
  max: 1.0,
  palette: palette,
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Annual EVI: Malaria Atlas Project Gap-Filled Enhanced Vegetation Index');

var areaOfInterest = ee.Geometry.Rectangle(
  [-20, -40, 100, 80], null, false);

var pixels = 256;
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

var image = means.visualize({palette: palette});
print(ui.Thumbnail({image: image, params: parameters}));