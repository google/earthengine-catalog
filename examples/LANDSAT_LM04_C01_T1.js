var dataset = ee.ImageCollection('LANDSAT/LM04/C01/T1')
                  .filterDate('1989-01-01', '1992-12-31');
var nearInfrared321 = dataset.select(['B3', 'B2', 'B1']);
var nearInfrared321Vis = {};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(nearInfrared321, nearInfrared321Vis, 'Near Infrared (321)');
