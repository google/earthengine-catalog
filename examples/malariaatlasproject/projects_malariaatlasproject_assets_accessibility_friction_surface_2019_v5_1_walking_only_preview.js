var dataset = ee.Image('projects/malariaatlasproject/assets/accessibility/friction_surface/2019_v5_1_walking_only');
var landBasedTravelSpeed = dataset.select('friction');
var palette = [
    '313695', '4575b4', '74add1', 'abd9e9', 'e0f3f8', 'ffffbf', 'fee090',
    'fdae61', 'f46d43', 'd73027', 'a50026'
];
var visParams = {
  min: 0.0022,
  max: 0.04,
  palette: palette,
};
Map.setCenter(43.55, 36.98, 4);
Map.addLayer(landBasedTravelSpeed, visParams, 'Land-based travel speed using non-motorized transport');

var areaOfInterest = ee.Geometry.Rectangle(
  [-20, -40, 100, 80], null, false);

var pixels = 256;
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

var image = landBasedTravelSpeed.visualize(visParams);
print(ui.Thumbnail({image: image, params: parameters}));