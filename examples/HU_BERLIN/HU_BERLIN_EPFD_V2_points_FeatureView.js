var fvLayer = ui.Map.FeatureViewLayer('HU_BERLIN/EPFD/V2/point_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  opacity: 1,
  width: 1,
  pointSize: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('European Primary Forest Points');

Map.setCenter(13.64, 50.11, 4);
Map.add(fvLayer);
