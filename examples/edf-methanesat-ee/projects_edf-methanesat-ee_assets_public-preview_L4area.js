var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area")
  .filterDate('2024-06-01', '2025-01-31');

var fluxVisParams = {
  min: 0,
  max: 18,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

Map.setCenter(-98.72, 36.49, 4);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux');