var dataset = ee.ImageCollection('MODIS/006/MCD43A4')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var trueColor = dataset.select([
  'Nadir_Reflectance_Band1', 'Nadir_Reflectance_Band4',
  'Nadir_Reflectance_Band3'
]);
var trueColorVis = {
  min: 0.0,
  max: 4000.0,
  gamma: 1.4,
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(trueColor, trueColorVis, 'True Color');