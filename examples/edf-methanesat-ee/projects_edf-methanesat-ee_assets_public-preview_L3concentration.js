var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L3concentration")
  .filterDate('2024-06-01', '2025-01-31');

var fluxVisParams = {
  bands: ['XCH4'],
  min: 1870,
  max: 2030,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

Map.setCenter(-42.26, 42.66, 3);
Map.addLayer(dataset, fluxVisParams, 'Retrieved column-averaged dry-air CH4 mole fraction');