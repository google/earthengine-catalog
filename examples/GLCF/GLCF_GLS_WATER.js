var dataset = ee.ImageCollection('GLCF/GLS_WATER');
var water = dataset.select('water');
var waterVis = {
  min: 1.0,
  max: 4.0,
  palette: ['fafafa', '00c5ff', 'df73ff', '828282', 'cccccc'],
};
Map.setCenter(-79.3094, 44.5693, 8);
Map.addLayer(water, waterVis, 'Water');
