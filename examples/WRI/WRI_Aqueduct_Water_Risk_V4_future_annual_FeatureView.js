var fvLayer = ui.Map.FeatureViewLayer(
    'WRI/Aqueduct_Water_Risk/V4/future_annual_FeatureView');

var visParams = {
  isVisible: false,
  pointSize: 20,
  rules: [{
    // Projected baseline water stress with low category by 2080
    filter: ee.Filter.eq('opt80_ws_x_c', -1),
    isVisible: true,
    pointFillColor: {
      property: 'opt80_ws_x_c',
      mode: 'linear',
      palette: ['f1eef6', 'd7b5d8', 'df65b0', 'ce1256'],
      min: -1,
      max: 100
    }
  }]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Projected Low Water Stress by 2080');

Map.setCenter(-10, 25, 5);
Map.add(fvLayer);