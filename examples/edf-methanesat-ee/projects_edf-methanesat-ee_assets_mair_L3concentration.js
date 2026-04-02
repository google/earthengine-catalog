// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/mair/L3concentration")
  .filterDate('2025-07-11', '2025-07-12');

var fluxVisParams = {
  bands: ['XCH4'],
  min: 1870,
  max: 2030,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

Map.setCenter(-42.26, 42.66, 3);
Map.addLayer(dataset, fluxVisParams, 'Retrieved column-averaged dry-air CH4 mole fraction');