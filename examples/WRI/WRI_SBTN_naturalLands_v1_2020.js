var dataset = ee.Image('WRI/SBTN/naturalLands/v1/2020').select('natural');

var lon = 0;
var lat = 0;

Map.setCenter(lon, lat, 2);

Map.addLayer(dataset, {}, 'Natural Lands');
