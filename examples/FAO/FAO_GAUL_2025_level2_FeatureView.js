var fvLayer = ui.Map.FeatureViewLayer('FAO/GAUL/2025/level2_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  width: 1,
  pointSize: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Second Level Administrative Units');

Map.setCenter(12.876, 42.682, 5);
Map.add(fvLayer);
