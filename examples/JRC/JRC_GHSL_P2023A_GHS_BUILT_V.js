var image_1975 = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_V/1975');
var image_2020 = ee.Image('JRC/GHSL/P2023A/GHS_BUILT_V/2020');
var volume_total_1975 = image_1975.select('built_volume_total');
var volume_total_2020 = image_2020.select('built_volume_total');


var visParams = {
  min: 0,
  max: 80000,
  palette: ['000004', '51127c', 'b73779', 'fc8961', 'fcfdbf'],
};

Map.setCenter(77.156, 28.6532, 10);
Map.addLayer(volume_total_1975, visParams, 'Total building volume [m3], 1975');
Map.addLayer(volume_total_2020, visParams, 'Total building volume [m3], 2020');