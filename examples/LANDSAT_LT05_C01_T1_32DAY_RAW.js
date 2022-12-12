var dataset = ee.ImageCollection('LANDSAT/LT05/C01/T1_32DAY_RAW')
                  .filterDate('2011-01-01', '2011-12-31');
var dataset = ee.ImageCollection('LANDSAT/LT05/C01/T1_32DAY_RAW');
var visParams = {
  min: 0,
  max: 255,
  gamma: 1.2,
  bands: ['B3', 'B2', 'B1'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(dataset, visParams, 'LANDSAT/LT05/C01/T1_32DAY_RAW');
