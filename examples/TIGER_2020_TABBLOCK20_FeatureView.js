var fvLayer = ui.Map.FeatureViewLayer('TIGER/2020/TABBLOCK20_FeatureView');

var visParams = {
  opacity: 1,
  color: {
    property: 'AWATER20',
    mode: 'linear',
    palette: ['d8d9d9', 'aaaaaa', 'b6dfe9', '2ea3f2', '0c71c3'],
    min: 0,
    max: 1e7
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Water area by US census block');

Map.setCenter(-73.15, 40.9, 9);
Map.add(fvLayer);
