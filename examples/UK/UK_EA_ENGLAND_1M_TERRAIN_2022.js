var img = ee.Image('UK/EA/ENGLAND_1M_TERRAIN/2022').select('dtm');
var visParam = {
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
  max: 630,
  min: -5,
};

var lon = -2.5;
var lat = 54;

Map.addLayer(img, visParam, 'dtm');
Map.setCenter(lon, lat, 5);