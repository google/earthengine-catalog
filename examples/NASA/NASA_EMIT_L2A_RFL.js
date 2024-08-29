var dataset = ee.ImageCollection('NASA/EMIT/L2A/RFL')
                  .filter(ee.Filter.date('2022-01-01', '2023-12-01'));
var emitRadVis = {
  min: 0,
  max: 0.1,
};
Map.setCenter(-121.4612, 38.334, 10);
Map.addLayer(
    dataset, emitRadVis,
    'Emit Reflectance');