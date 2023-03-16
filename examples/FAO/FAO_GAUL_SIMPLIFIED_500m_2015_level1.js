var dataset = ee.FeatureCollection("FAO/GAUL_SIMPLIFIED_500m/2015/level1");

Map.setCenter(7.82, 49.1, 4);

var styleParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 1.0,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'First Level Administrative Units');
