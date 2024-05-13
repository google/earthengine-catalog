var fvLayer = ui.Map.FeatureViewLayer('WM/geoLab/geoBoundaries/600/ADM1_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  width: 1,
  pointSize: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('ADM1 Boundaries');

Map.setCenter(-100.0, 38.5, 4);
Map.add(fvLayer);
