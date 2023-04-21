var fvLayer = ui.Map.FeatureViewLayer(
  'WWF/HydroSHEDS/v1/Basins/hybas_3_FeatureView');

var visParams = {
  color: '808080',
  lineWidth: 1
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Basins');

Map.setCenter(-117.731, 53.033, 7);
Map.add(fvLayer);
