var fvLayer = ui.Map.FeatureViewLayer('FAO/GAUL/2015/level2_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  width: 1,
  pointSize: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Second Level Administrative Units');

Map.setCenter(7.82, 49.1, 4);
Map.add(fvLayer);
