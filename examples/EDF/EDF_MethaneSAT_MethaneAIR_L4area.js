var dataset = ee.ImageCollection("EDF/MethaneSAT/MethaneAIR/L4area");

var fluxVisParams = {
  min: 0,
  max: 18,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

// Center on one of the available areas of interests.
Map.setCenter(-102.5, 31.85, 8);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux');