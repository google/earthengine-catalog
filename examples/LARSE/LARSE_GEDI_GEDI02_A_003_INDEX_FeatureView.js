var fvLayer =
    ui.Map.FeatureViewLayer('LARSE/GEDI/GEDI02_A_003_INDEX_FeatureView');

var visParams = {
  color: '004d00',
  fillColor: '2ca02c',
  opacity: 0.5,
  width: 1,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('GEDI L2A Table Index (Version 3)');

Map.setCenter(-60.0, -5.0, 4);
Map.add(fvLayer);
