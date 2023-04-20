var dataset = ee.ImageCollection('LANDSAT/LC08/C01/T1_ANNUAL_RAW')
                  .filterDate('2017-01-01', '2017-12-31');
var visParams = {
  min: 0,
  max: 20000,
  gamma: 1.2,
  bands: ['B4', 'B3', 'B2'],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(dataset, visParams, 'LANDSAT/LC08/C01/T1_ANNUAL_RAW');
