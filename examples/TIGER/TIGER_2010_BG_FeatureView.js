var fvLayer = ui.Map.FeatureViewLayer('TIGER/2010/BG_FeatureView');

var visParams = {
  opacity: 1,
  color: {
    property: 'AWATER10',
    mode: 'linear',
    palette: ['d8d9d9', 'aaaaaa', 'b6dfe9', '2ea3f2', '0c71c3'],
    min: 0,
    max: 1e7
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Water area 2010 by US census block group');

Map.setCenter(-73.99172, 40.74101, 13);
Map.add(fvLayer);
