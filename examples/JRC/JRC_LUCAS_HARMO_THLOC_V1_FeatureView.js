var fvLayer = ui.Map.FeatureViewLayer('JRC/LUCAS_HARMO/THLOC/V1_FeatureView');

var visParams = {
  pointSize: 8,
  color: '808080',
  pointFillColor: {
    property: 'inspire_plcc4',
    mode: 'linear',
    palette: ['ffffcc','c2e699','78c679','238443'],
    min: 0,
    max: 100
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('LUCAS herbaceous cover');

Map.setCenter(-3.8233, 40.609, 10);
Map.add(fvLayer);
