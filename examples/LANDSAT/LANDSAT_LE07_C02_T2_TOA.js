var dataset = ee.ImageCollection("LANDSAT/LE07/C02/T2_TOA")
    .filterDate('1999-01-01', '2002-12-31');
var trueColor321 = dataset.select(['B3', 'B2', 'B1']);
var trueColor321Vis = {
  min: 0.0,
  max: 0.4,
  gamma: 1.2,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor321, trueColor321Vis, 'True Color (321)');
