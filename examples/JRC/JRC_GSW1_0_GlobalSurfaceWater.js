var dataset = ee.Image('JRC/GSW1_0/GlobalSurfaceWater');
var occurrence = dataset.select('occurrence');
var occurrenceVis = {
  min: 0.0,
  max: 100.0,
  palette: ['ffffff', 'ffbbbb', '0000ff'],
};
Map.setCenter(59.414, 45.182, 6);
Map.addLayer(occurrence, occurrenceVis, 'Occurrence');