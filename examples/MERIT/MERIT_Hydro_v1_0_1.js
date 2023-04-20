var dataset = ee.Image('MERIT/Hydro/v1_0_1');

var visualization = {
  bands: ['viswth'],
};

Map.setCenter(90.301, 23.052, 10);

Map.addLayer(dataset, visualization, 'River width');
