var fvLayer = ui.Map.FeatureViewLayer('WCMC/WDPCA/current/points_FeatureView');

var visParams = {
  color: '4285F4',
  pointShape: 'circle',
  pointSize: 7,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Site Points');

Map.setCenter(24.17, 2.22, 4);
Map.add(fvLayer);
