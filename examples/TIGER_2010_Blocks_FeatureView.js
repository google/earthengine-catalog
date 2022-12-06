var fvLayer = ui.Map.FeatureViewLayer('TIGER/2010/Blocks_FeatureView');

var visParams = {
  opacity: 1,
  color: {
    property: 'pop10',
    mode: 'linear',
    palette: ['black', 'brown', 'yellow', 'orange', 'red'],
    min: 0,
    max: 700
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census blocks');

Map.setCenter(-73.99172, 40.74101, 13);
Map.add(fvLayer);
