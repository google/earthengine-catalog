var fvLayer = ui.Map.FeatureViewLayer(
  'USFS/GTAC/MTBS/burned_area_boundaries/v1_FeatureView');

var visParams = {
  color: 'ff5722',
  fillColor: 'ff8a50',
  width: 2,
  opacity: 0.8
};

fvLayer.setVisParams(visParams);
fvLayer.setName('USFS/GTAC/MTBS/burned_area_boundaries/v1');

Map.setCenter(-122.2988, 38.8766, 10);
Map.add(fvLayer);
