var dataset = ee.Image('FORMA/FORMA_500m');

var visualization = {
  bands: ['constant'],
  min: 1134979200.0,
  max: 1433919600.0,
  palette: ['ff0000']
};

Map.setCenter(-51.482, -0.835, 6);

Map.addLayer(dataset, visualization, 'Alert Areas');
