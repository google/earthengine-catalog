var dataset = ee.Image(
    'projects/nature-trace/assets/species_distribution_models/australia_mammals/v0');
var species = dataset.select('GreaterGlider');
var occurenceVis = {
  min: 0,
  max: 250,
  palette: [
    '0000FF', '004FFF', '009DFF', '00ECFF', '00FFC4', '00FF75', '00FF27',
    '28FF00', '76FF00', 'C5FF00', 'FFEB00', 'FF9C00', 'FF4E00', 'FF0000'
  ]
};
Map.setCenter(133.4, -26.6, 5);
Map.addLayer(species, occurenceVis, 'GreaterGlider');