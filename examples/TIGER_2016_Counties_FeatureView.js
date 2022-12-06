var fvLayer = ui.Map.FeatureViewLayer('TIGER/2016/Counties_FeatureView');

var visParams = {
  opacity: 1,
  polygonStrokeColor: 'black',
  polygonFillColor: {
    property: 'STATEFP',
    categories: [
      ['08', 'purple'],  // Colorado counties
      ['32', 'blue']     // Nevada counties
    ],
    defaultValue: 'white'
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census counties');

Map.setCenter(-99.844, 37.649, 5);
Map.add(fvLayer);
