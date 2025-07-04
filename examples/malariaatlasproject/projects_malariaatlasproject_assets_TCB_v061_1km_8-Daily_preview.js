var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/TCB_v061/1km/8-Daily')
                  .filter(ee.Filter.date('2022-01-01', '2022-04-01'));
var means = dataset.select('Mean');
var visParams = {
  min: 0.0,
  max: 1.3,
  palette: ['011301','004c00','056201','207401','3e8601','66a000','99b718','fcd163','ffffff'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, '8-Daily TCB: Malaria Atlas Project Gap-Filled Tasseled Cap Brightness');

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