var dataset = ee.ImageCollection('projects/covariate/assets/TCB_v061/5km/Annual')
                  .filter(ee.Filter.date('2018-01-01', '2023-01-01'));
var means = dataset.select('Mean');
var visParams = {
  min: 0.0,
  max: 1.3,
  palette: ['011301','004c00','056201','207401','3e8601','66a000','99b718','fcd163','ffffff'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Annual TCB: Malaria Atlas Project Gap-Filled Tasseled Cap Brightness');