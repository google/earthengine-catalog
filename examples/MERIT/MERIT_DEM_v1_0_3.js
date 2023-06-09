var dataset = ee.Image('MERIT/DEM/v1_0_3');

var visualization = {
  bands: ['dem'],
  min: -3,
  max: 18,
  palette: [
    '000000', '478fcd', '86c58e', 'afc35e',
    '8f7131', 'b78d4f', 'e2b8a6', 'ffffff']
};

Map.setCenter(90.301, 23.052, 10);

Map.addLayer(dataset, visualization, 'Elevation');
