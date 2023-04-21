var fvLayer = ui.Map.FeatureViewLayer('WCMC/WDPA/current/points_FeatureView');

var visParams = {
  color: '4285F4',
  pointShape: 'circle',
  pointSize: 7,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Protected Area Points');

Map.setCenter(110.57, 0.88, 4);
Map.add(fvLayer);
