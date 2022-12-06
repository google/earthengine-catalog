var dataset = ee.FeatureCollection('USFS/GTAC/MTBS/burned_area_boundaries/v1');

var visParams = {
  fillColor: 'ff8a50',
  color: 'ff5722',
  width: 1.0,
};

Map.setCenter(-122.2988, 38.8766, 10);
Map.addLayer(dataset, visParams, 'USFS/GTAC/MTBS/burned_area_boundaries/v1');
