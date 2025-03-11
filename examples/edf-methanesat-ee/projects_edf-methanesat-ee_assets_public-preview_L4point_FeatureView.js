var fvLayer = ui.Map.FeatureViewLayer('projects/edf-methanesat-ee/assets/public-preview/L4point_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  pointSize: 5
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Feature view of methane point sources flux in kg/h');

Map.setCenter(-43.03, 37.48, 3);
Map.add(fvLayer);