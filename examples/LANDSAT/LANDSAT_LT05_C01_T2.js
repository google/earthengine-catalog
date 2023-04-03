var dataset = ee.ImageCollection('LANDSAT/LT05/C01/T2')
                  .filterDate('2011-01-01', '2011-12-31');
var trueColor321 = dataset.select(['B3', 'B2', 'B1']);
var trueColor321Vis = {};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor321, trueColor321Vis, 'True Color (321)');
