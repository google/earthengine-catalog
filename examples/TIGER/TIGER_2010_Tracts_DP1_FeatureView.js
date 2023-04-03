var fvLayer = ui.Map.FeatureViewLayer('TIGER/2010/Tracts_DP1_FeatureView');

var visParams = {
  opacity: 0.8,
  color: {
    property: 'dp0010001',
    mode: 'linear',
    palette: ['black', 'white'],
    min: 0,
    max: 4000
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census tracts demographics');

Map.setCenter(-103.882, 43.036, 8);
Map.add(fvLayer);
