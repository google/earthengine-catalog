var dataset = ee.ImageCollection('LANDSAT/LM01/C01/T1')
                  .filterDate('1974-01-01', '1978-12-31');
var nearInfrared321 = dataset.select(['B6', 'B5', 'B4']);
var nearInfrared321Vis = {};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(nearInfrared321, nearInfrared321Vis, 'Near Infrared (321)');
