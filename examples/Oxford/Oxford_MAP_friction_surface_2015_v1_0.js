var dataset = ee.Image('Oxford/MAP/friction_surface_2015_v1_0');
var landBasedTravelSpeed = dataset.select('friction');
var visParams = {
  min: 0.0022,
  max: 0.04,
  palette: [
    '313695', '4575b4', '74add1', 'abd9e9', 'e0f3f8', 'ffffbf', 'fee090',
    'fdae61', 'f46d43', 'd73027', 'a50026'
  ],
};
Map.setCenter(43.55, 36.98, 4);
Map.addLayer(landBasedTravelSpeed, visParams, 'Land-based travel speed');
