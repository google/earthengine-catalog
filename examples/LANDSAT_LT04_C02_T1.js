var dataset = ee.ImageCollection('LANDSAT/LT04/C02/T1')
                  .filterDate('1989-01-01', '1992-12-31');
var trueColor321 = dataset.select(['B3', 'B2', 'B1']);
var trueColor321Vis = {};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor321, trueColor321Vis, 'True Color (321)');
