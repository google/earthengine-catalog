var fvLayer = ui.Map.FeatureViewLayer('EDF/MethaneSAT/MethaneAIR/methaneair-L4point-2021_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  pointSize: 10
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Feature view of methane point sources flux in kg/h');

// Center on one of the two available areas of interests.
// Map.setCenter(-109.6, 40, 9)
Map.setCenter(-103.71, 31.96, 9);
Map.add(fvLayer);