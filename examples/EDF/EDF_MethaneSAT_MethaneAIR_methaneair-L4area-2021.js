var dataset = ee.Image("EDF/MethaneSAT/MethaneAIR/methaneair-L4area-2021");

var fluxVisParams = {
  min: 0,
  max: 24,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
};

// Center on one of the two available areas of interests.
// Map.setCenter(-109.6, 40, 9)
Map.setCenter(-103.71, 31.96, 9);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux');