var fvLayer = ui.Map.FeatureViewLayer(
  'GOOGLE/Research/open-buildings/v1/polygons_FeatureView');

var visParams = {
  rules: [
    {
      filter: ee.Filter.expression('confidence >= 0.60 && confidence < 0.65'),
      color: 'FF0000'
    },
    {
      filter: ee.Filter.expression('confidence >= 0.65 && confidence < 0.70'),
      color: 'FFFF00'
    },
    {
      filter: ee.Filter.expression('confidence >= 0.70'),
      color: '00FF00'
    },
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Buildings');

Map.setCenter(3.389, 6.492, 17);  // Lagos, Nigeria
Map.add(fvLayer);
Map.setOptions('SATELLITE');
