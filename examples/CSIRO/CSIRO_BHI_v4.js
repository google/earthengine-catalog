var dataset = ee.ImageCollection('CSIRO/BHI/v4');
var bhi = dataset.filter(ee.Filter.date('2024-01-01', '2025-01-01')).first().select('bhi');

var visualization = {
  min: 0.0,
  max: 1.0,
  palette: ['440154', '3b528b', '21918c', '5ec962', 'fde725']
};

Map.setCenter(133.78, -25.27, 4);
Map.addLayer(bhi, visualization, 'Biodiversity Habitat Index (BHI)');
