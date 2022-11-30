var fvLayer = ui.Map.FeatureViewLayer('TIGER/2016/States_FeatureView');

var visParams = {
  opacity: 0.8,
  color: {
    property: 'ALAND',
    mode: 'linear',
    palette: ['purple', 'blue', 'green', 'yellow', 'orange', 'red'],
    min: 5e8,
    max: 5e11
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census states');

Map.setCenter(-99.844, 37.649, 5);
Map.add(fvLayer);
