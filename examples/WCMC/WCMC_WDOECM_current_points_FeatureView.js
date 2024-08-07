var fvLayer = ui.Map.FeatureViewLayer('WCMC/WDOECM/current/points_FeatureView');

var visParams = {
  color: '4285F4',
  pointShape: 'circle',
  pointSize: 6,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Protected Area Points');

Map.setCenter(124.49, 11.63, 6);
Map.add(fvLayer);
