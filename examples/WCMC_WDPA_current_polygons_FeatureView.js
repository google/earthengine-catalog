var fvLayer = ui.Map.FeatureViewLayer('WCMC/WDPA/current/polygons_FeatureView');

var visParams = {
  color: {
    property: 'REP_AREA',
    mode: 'linear',
    palette: ['2ed033', '5aff05', '67b9ff', '5844ff', '0a7618', '2c05ff'],
    min: 0.0,
    max: 1550000.0
  },
  opacity: 0.8
};

fvLayer.setVisParams(visParams);
fvLayer.setName('WCMC/WDPA/current/polygons');

Map.setCenter(41.104, -17.724, 6);
Map.add(fvLayer);
