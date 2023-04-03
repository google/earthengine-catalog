var fvLayer = ui.Map.FeatureViewLayer('USGS/WBD/2017/HUC10_FeatureView');

var visParams = {
  color: '808080',
  lineWidth: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Basins');

Map.setCenter(-105.861, 39.529, 7);
Map.add(fvLayer);
