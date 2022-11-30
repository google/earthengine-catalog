var fvLayer = ui.Map.FeatureViewLayer(
  'WWF/HydroSHEDS/v1/FreeFlowingRivers_FeatureView');

var visParams = {
  lineWidth: 2,
  color: {
    property: 'RIV_ORD',
    mode: 'linear',
    palette: ['08519c', '3182bd', '6baed6', 'bdd7e7', 'eff3ff'],
    min: 1,
    max: 10
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Free flowing rivers');

Map.setCenter(-122.348, 45.738, 9);
Map.add(fvLayer);
