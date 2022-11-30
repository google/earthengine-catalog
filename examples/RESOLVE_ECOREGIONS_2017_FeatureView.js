var fvLayer = ui.Map.FeatureViewLayer('RESOLVE/ECOREGIONS/2017_FeatureView');

var visParams = {
  opacity: 1,
  polygonFillColor: {
    property: 'NNH_NAME',
    categories: [
      ['Half Protected', 'blue'],
      ['Nature Could Reach Half Protected', 'green'],
      ['Nature Could Recover', 'yellow'],
      ['Nature Imperiled', 'orange']
    ],
    defaultValue: 'lightgrey'
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Ecoregions (Nature Needs Half category)');

Map.setCenter(16, 49, 4);
Map.add(fvLayer);
