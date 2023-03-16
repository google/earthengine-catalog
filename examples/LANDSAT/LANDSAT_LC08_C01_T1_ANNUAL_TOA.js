var dataset = ee.ImageCollection('LANDSAT/LC08/C01/T1_ANNUAL_TOA')
                  .filterDate('2017-01-01', '2017-12-31');
var trueColor = dataset.select(['B4', 'B3', 'B2']);
var trueColorVis = {
  min: 0,
  max: 0.4,
  gamma: 1.2,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor, trueColorVis, 'True Color (432)');
