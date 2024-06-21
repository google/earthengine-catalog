var fvLayer = ui.Map.FeatureViewLayer('NOAA/IBTrACS/v4_FeatureView');

var visParams = {
  isVisible: false,
  pointSize: 20,
  rules: [
    {
      filter: ee.Filter.eq('SEASON', 2020),
      isVisible: true,
      pointFillColor: {
        property: 'STORM_SPEED',
        mode: 'linear',
        palette: ['f1eef6', 'd7b5d8', 'df65b0', 'ce1256'],
        min: 0,
        max: 100
      }
    }
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('2020 storm speed');

Map.setLocked(false, 4);
Map.setCenter(-62.25, 32.19, 4);
Map.add(fvLayer);
