var dataset = ee.Image("EDF/MethaneSAT/MethaneAIR/methaneair-L4area-2021");
var fluxVisParams = {
  palette: ['navy', 'magenta', 'orange', 'yellow'],
  min: 0,
  max: 23
};

// Utah
// Map.setCenter(-109.6, 40, 9)
// Texas / New Mexico
Map.setCenter(-103.71, 31.96, 9);
Map.addLayer(dataset, fluxVisParams, 'Methane area sources flux')