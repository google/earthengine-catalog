var dataset = ee.ImageCollection('NASA/NLDAS/FORA0125_H002')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-30'));
var temperature = dataset.select('temperature');
var temperatureVis = {
  min: -5.0,
  max: 40.0,
  palette: ['3d2bd8', '4e86da', '62c7d8', '91ed90', 'e4f178', 'ed6a4c'],
};
Map.setCenter(-110.21, 35.1, 4);
Map.addLayer(temperature, temperatureVis, 'Temperature');
