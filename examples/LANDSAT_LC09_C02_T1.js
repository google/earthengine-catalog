var dataset = ee.ImageCollection('LANDSAT/LC09/C02/T1')
                  .filterDate('2022-01-01', '2022-02-01');
var trueColor432 = dataset.select(['B4', 'B3', 'B2']);
var trueColor432Vis = {
  min: 0.0,
  max: 30000.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor432, trueColor432Vis, 'True Color (432)');
