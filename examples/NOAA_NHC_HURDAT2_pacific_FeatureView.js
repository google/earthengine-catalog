var fvLayer = ui.Map.FeatureViewLayer('NOAA/NHC/HURDAT2/pacific_FeatureView');

var visParams = {
  isVisible: false,
  pointSize: 20,
  rules: [
    {
      filter: ee.Filter.eq('year', 2018),
      isVisible: true,
      pointFillColor: {
        property: 'max_wind_kts',
        mode: 'linear',
        palette: ['f1eef6', 'd7b5d8', 'df65b0', 'ce1256'],
        min: 15,
        max: 140
      }
    }
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('2018 hurricane max wind speed');

Map.setLocked(false, 4);
Map.setCenter(-130, 20, 4);
Map.add(fvLayer);
