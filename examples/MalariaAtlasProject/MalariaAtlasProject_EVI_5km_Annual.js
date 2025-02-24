var dataset = ee.ImageCollection('projects/covariate/assets/EVI_v061/5km/Annual')
                  .filter(ee.Filter.date('2018-01-01', '2023-01-01'));
var means = dataset.select('Mean');
var visParams = {
  min: 0.0,
  max: 1.0,
  palette: ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Annual EVI: Malaria Atlas Project Gap-Filled Enhanced Vegetation Index');