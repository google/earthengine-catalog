var dataset = ee.ImageCollection('CSIRO/BHI/v2');
var habitatVis = {
  min: 0.0,
  max: 1.0,
  palette: ['red', 'yellow', 'green'],
};

Map.setCenter(133.0, -25.0, 4);
Map.addLayer(dataset.select('proportion_habitat'), habitatVis, 'Proportion of Habitat Retained');
