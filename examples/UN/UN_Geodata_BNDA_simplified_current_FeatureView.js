var fvLayer = ui.Map.FeatureViewLayer('UN/Geodata/BNDA_simplified/current_FeatureView');

var visParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 1.0,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('BNDA Simplified');

Map.setCenter(-100.0, 38.5, 4);
Map.add(fvLayer);
