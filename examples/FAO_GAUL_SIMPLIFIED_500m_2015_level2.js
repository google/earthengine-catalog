var dataset = ee.FeatureCollection("FAO/GAUL_SIMPLIFIED_500m/2015/level2");

Map.setCenter(12.876, 42.682, 5);

var styleParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 1.0,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'Second Level Administrative Units');
