// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area_v2");

var fluxVisParams = {
  bands: ['mean_flux'],
  min: 0,
  max: 625,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

Map.setCenter(-98.72, 36.49, 4);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux');