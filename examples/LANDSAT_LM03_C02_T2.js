var dataset = ee.ImageCollection('LANDSAT/LM03/C02/T2')
                  .filterDate('1978-01-01', '1980-12-31');
var nearInfrared321 = dataset.select(['B6', 'B5', 'B4']);
var nearInfrared321Vis = {};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(nearInfrared321, nearInfrared321Vis, 'Near Infrared (321)');
