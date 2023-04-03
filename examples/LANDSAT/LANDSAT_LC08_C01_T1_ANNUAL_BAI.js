var dataset = ee.ImageCollection('LANDSAT/LC08/C01/T1_ANNUAL_BAI')
                  .filterDate('2017-01-01', '2017-12-31');
var scaled = dataset.select('BAI');
var scaledVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(scaled, scaledVis, 'Scaled');
