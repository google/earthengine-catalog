var fvLayer = ui.Map.FeatureViewLayer('EDF/MethaneSAT/MethaneAIR/L4point_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  pointSize: 5
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Feature view of methane point sources flux in kg/h');

// Center on one of the available areas of interests.
Map.setCenter(-102.5, 31.85, 8);
Map.add(fvLayer);