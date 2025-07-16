var dataset = ee.ImageCollection('projects/malariaatlasproject/assets/LST_Day_v061/1km/Annual')
                  .filter(ee.Filter.date('2018-01-01', '2023-01-01'));
var means = dataset.select('Mean');
var visParams = {
  min: -20.0,
  max: 50.0,
  palette: ['800080','0000ab','0000ff','008000','19ff2b','a8f7ff','ffff00','d6d600','ffa500','ff6b01','ff0000'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, 'Annual LST Day: Malaria Atlas Project Gap-Filled Daytime Land Surface Temperature');

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