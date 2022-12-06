var dataset = ee.ImageCollection('LANDSAT/LE07/C01/T1_32DAY_TOA')
                  .filterDate('1999-01-01', '2002-12-31');
var trueColor = dataset.select(['B3', 'B2', 'B1']);
var trueColorVis = {
  min: 0,
  max: 0.4,
  gamma: 1.2,
};
Map.setCenter(-3.7408, 40.4386, 8);
Map.addLayer(trueColor, trueColorVis, 'True Color (321)');
