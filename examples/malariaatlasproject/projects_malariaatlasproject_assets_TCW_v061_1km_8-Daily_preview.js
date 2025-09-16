var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/TCW_v061/1km/8-Daily')
                  .filter(ee.Filter.date('2022-01-01', '2022-04-01'));
var means = dataset.select('Mean').mean();
var palette = ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'];
var visParams = {
  min: -0.6,
  max: 0.5,
  palette: palette,
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, '8-Daily TCW: Malaria Atlas Project Gap-Filled Tasseled Cap Wetness');

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