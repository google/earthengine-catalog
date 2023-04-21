var dataset = ee.ImageCollection('LANDSAT/LC08/C01/T2_TOA')
                  .filterDate('2017-01-01', '2017-12-31');
var trueColor432 = dataset.select(['B4', 'B3', 'B2']);
var trueColor432Vis = {
  min: 0.0,
  max: 0.4,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor432, trueColor432Vis, 'True Color (432)');
