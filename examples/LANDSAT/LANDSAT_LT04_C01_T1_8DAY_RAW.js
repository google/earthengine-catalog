var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_8DAY_RAW')
                  .filterDate('1989-01-01', '1992-12-31');
var dataset = ee.ImageCollection('LANDSAT/LT04/C01/T1_8DAY_RAW');
var visParams = {
  min: 0,
  max: 255,
  gamma: 1.2,
  bands: ['B3', 'B2', 'B1'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(dataset, visParams, 'LANDSAT/LT04/C01/T1_8DAY_RAW');
