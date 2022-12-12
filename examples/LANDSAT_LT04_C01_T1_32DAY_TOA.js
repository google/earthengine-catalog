var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_32DAY_TOA')
                  .filterDate('1989-01-01', '1992-12-31');
var trueColor = dataset.select(['B3', 'B2', 'B1']);
var trueColorVis = {
  min: 0,
  max: 0.4,
  gamma: 1.2,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor, trueColorVis, 'True Color (432)');
