var dataset = ee.ImageCollection('projects/nature-trace/assets/ghg/emit/mapl_emit_enhancements_v1_0');

var visParamsEnhancement = {
  min: 0,
  max: 300,
  palette: ['#000004', '#1b0c41', '#4a0c6b', '#781c6d', '#a52c60', '#cf4446', '#ed6925', '#fb9b06', '#f7d13d', '#fcffa4']
};

Map.setCenter(54.16, 38.4604, 8);
Map.addLayer(dataset.select(1), {min: 0, max: 1, palette: ['white', 'black']}, 'Plume probability');
Map.addLayer(dataset.select(0), visParamsEnhancement, 'Granule enhancement');
