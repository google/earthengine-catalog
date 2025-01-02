var fvLayer = ui.Map.FeatureViewLayer(
    'WRI/Aqueduct_Water_Risk/V4/baseline_monthly_FeatureView');

var visParams = {
  isVisible: false,
  pointSize: 20,
  rules: [{
    // Baseline water stress with low category in January
    filter: ee.Filter.eq('bws_01_cat', -1),
    isVisible: true,
    pointFillColor: {
      property: 'bws_01_cat',
      mode: 'linear',
      palette: ['f1eef6', 'd7b5d8', 'df65b0', 'ce1256'],
      min: -1,
      max: 100
    }
  }]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Low Water Stress January');

Map.setCenter(-10, 25, 5);
Map.add(fvLayer);
