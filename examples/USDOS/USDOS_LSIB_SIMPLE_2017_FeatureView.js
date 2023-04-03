var fvLayer = ui.Map.FeatureViewLayer('USDOS/LSIB_SIMPLE/2017_FeatureView');

var visParams = {
  color: '00909F',
  fillColor: 'b5ffb4',
  width: 3,
  opacity: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('USDOS/LSIB_SIMPLE/2017');

Map.setCenter(16.35, 48.83, 4);
Map.add(fvLayer);
