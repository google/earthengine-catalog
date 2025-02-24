var dataset = ee.ImageCollection('projects/covariate/assets/LST_Day_v061/1km/8-Daily')
                  .filter(ee.Filter.date('2022-01-01', '2022-04-01'));
var means = dataset.select('Mean');
var visParams = {
  min: -20.0,
  max: 50.0,
  palette: ['800080','0000ab','0000ff','008000','19ff2b','a8f7ff','ffff00','d6d600','ffa500','ff6b01','ff0000'],
};
Map.setCenter(0, 0, 2);
Map.addLayer(means, visParams, '8-Daily LST Day: Malaria Atlas Project Gap-Filled Daytime Land Surface Temperature');