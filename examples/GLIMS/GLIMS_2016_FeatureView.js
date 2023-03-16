var fvLayer = ui.Map.FeatureViewLayer('GLIMS/2016_FeatureView');

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
fvLayer.setName('GLIMS/2016');

Map.setCenter(-26.763, 73.214, 6);
Map.add(fvLayer);
