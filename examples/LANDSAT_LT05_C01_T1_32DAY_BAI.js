var dataset = ee.ImageCollection('LANDSAT/LT05/C01/T1_32DAY_BAI')
                  .filterDate('2011-01-01', '2011-12-31');
var scaled = dataset.select('BAI');
var scaledVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(scaled, scaledVis, 'Scaled');
