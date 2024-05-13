var dataset = ee.FeatureCollection('WM/geoLab/geoBoundaries/600/ADM2');

Map.setCenter(-100.0, 38.5, 4);

var styleParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 1.0,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'ADM2 Boundaries');
