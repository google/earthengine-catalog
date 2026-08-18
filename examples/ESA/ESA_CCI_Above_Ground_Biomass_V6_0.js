var image = ee.Image('ESA/CCI/Above_Ground_Biomass/V6_0/2020');
var agb = image.select('agb');

var visParams = {
  min: 0,
  max: 500,
  palette: ['white', 'green'],
};

Map.setCenter(-60, -3, 4);
Map.addLayer(agb, visParams, 'Above Ground Biomass 2020');
