var fvLayer = ui.Map.FeatureViewLayer('TIGER/2016/Roads_FeatureView');

var visParams = {
  color: '4285f4'
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census roads');

Map.setCenter(-73.99172, 40.74101, 14);
Map.add(fvLayer);
