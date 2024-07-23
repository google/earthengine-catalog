var dataset = ee.ImageCollection('NASA/EMIT/L1B/RAD');
var emitRadVis = {
  min: 0,
  max: 10.0,
};
Map.setCenter(-122.59, 38.34, 10);
Map.addLayer(
    dataset, emitRadVis,
    'Emit Radiance');