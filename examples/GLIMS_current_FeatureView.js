var fvLayer = ui.Map.FeatureViewLayer('GLIMS/current_FeatureView');

var visParams = {
  color: {
    property: 'area',
    mode: 'linear',
    palette: ['gray', 'cyan', 'blue'],
    min: 0.0,
    max: 10.0
  },
  opacity: 0.8,
  polygonStrokeOpacity: 0
};

fvLayer.setVisParams(visParams);
fvLayer.setName('GLIMS/current');

Map.setCenter(-35.618, 66.743, 7);
Map.add(fvLayer);
