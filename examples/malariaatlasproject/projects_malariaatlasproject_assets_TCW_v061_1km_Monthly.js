var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/TCW_v061/1km/Monthly')
                  .filter(ee.Filter.date('2022-01-01', '2022-12-31'));
var means = dataset.select('Mean');
var visParams = {
  min: -0.6,
  max: 0.5,
  palette: ['ffffff','fcd163','99b718','66a000','3e8601','207401','056201','004c00','011301'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Monthly TCW: Malaria Atlas Project Gap-Filled Tasseled Cap Wetness');