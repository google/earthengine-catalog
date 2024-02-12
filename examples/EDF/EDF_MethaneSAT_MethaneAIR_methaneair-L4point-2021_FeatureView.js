var fvLayer = ui.Map.FeatureViewLayer('EDF/MethaneSAT/MethaneAIR/methaneair-L4point-2021_featureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  pointSize: 10
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Feature view of methane point sources flux in kg/h');

// Utah
// Map.setCenter(-109.6, 40, 9)
// Texas / New Mexico
Map.setCenter(-103.71, 31.96, 9);
Map.add(fvLayer);