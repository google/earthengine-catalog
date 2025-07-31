var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/LST_Night_v061/1km/Monthly')
                  .filter(ee.Filter.date('2022-01-01', '2022-12-31'));
var means = dataset.select('Mean');
var visParams = {
  min: -20.0,
  max: 50.0,
  palette: ['800080','0000ab','0000ff','008000','19ff2b','a8f7ff','ffff00','d6d600','ffa500','ff6b01','ff0000'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Monthly LST Night: Malaria Atlas Project Gap-Filled Nighttime Land Surface Temperature');

var areaOfInterest = ee.Geometry.Rectangle(
  [-20, -40, 100, 80], null, false);

var pixels = 256;
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png'
};

var image = means.visualize({palette: palette});
print(ui.Thumbnail({image: image, params: parameters}));