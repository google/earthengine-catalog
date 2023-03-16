var fvLayer = ui.Map.FeatureViewLayer('TIGER/2010/ZCTA5_FeatureView');

var visParams = {
  opacity: 1,
  polygonStrokeColor: 'black',
  polygonFillColor: {
    property: 'ALAND10',
    mode: 'linear',
    palette: ['black', 'purple', 'blue', 'green', 'yellow', 'orange', 'red'],
    min: 5e5,
    max: 5e9
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('US census zip codes');

Map.setCenter(-93.8008, 40.7177, 6);
Map.add(fvLayer);
