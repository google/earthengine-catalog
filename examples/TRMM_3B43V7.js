var dataset = ee.ImageCollection('TRMM/3B43V7')
                  .filter(ee.Filter.date('2018-04-01', '2018-05-01'));
var precipitation = dataset.select('precipitation');
var precipitationVis = {
  min: 0.1,
  max: 1.2,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(6.746, 46.529, 3);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
