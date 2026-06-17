var fvLayer = ui.Map.FeatureViewLayer('JRC/LUCAS/THLOC/V1/2022_FeatureView');

var visParams = {
  pointSize: 8,
  color: '808080',
  pointFillColor: {
    property: 'SURVEY_INSPIRE_PLCC4',
    mode: 'linear',
    palette: ['ffffcc','c2e699','78c679','238443'],
    min: 0,
    max: 100
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('LUCAS herbaceous cover 2022');

Map.setCenter(-6.0, 37.0, 10);
Map.add(fvLayer);
