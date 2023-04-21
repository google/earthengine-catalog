var dataset = ee.ImageCollection('LANDSAT/LE7_TOA_1YEAR');
var trueColor321 = dataset.select(['B3', 'B2', 'B1']);
var trueColor321Vis = {
  min: 0.0,
  max: 120.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor321, trueColor321Vis, 'True Color (321)');