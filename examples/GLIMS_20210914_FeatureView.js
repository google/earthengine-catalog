var fvLayer = ui.Map.FeatureViewLayer('GLIMS/20210914_FeatureView');

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
fvLayer.setName('GLIMS/20210914');

Map.setCenter(-35.618, 66.743, 7);
Map.add(fvLayer);
