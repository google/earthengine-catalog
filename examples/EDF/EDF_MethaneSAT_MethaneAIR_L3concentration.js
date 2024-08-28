var dataset = ee.ImageCollection("EDF/MethaneSAT/MethaneAIR/L3concentration");

var fluxVisParams = {
  bands: ['XCH4'],
  min: 1870,
  max: 2030,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

// Center on one of the available areas of interests.
Map.setCenter(-102.9, 32, 8);
Map.addLayer(dataset, fluxVisParams, 'Retrieved column-averaged dry-air CH4 mole fraction');