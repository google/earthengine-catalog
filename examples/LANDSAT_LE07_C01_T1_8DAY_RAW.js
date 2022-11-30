var dataset = ee.ImageCollection('LANDSAT/LE07/C01/T1_8DAY_RAW')
                  .filterDate('1999-01-01', '2002-12-31');
var visParams = {
  min: 0,
  max: 255,
  gamma: 1.2,
  bands: ['B3', 'B2', 'B1'],
};
Map.setCenter(24.236, -28.941, 6);
Map.addLayer(dataset, visParams, 'LANDSAT/LE07/C01/T1_8DAY_RAW');
