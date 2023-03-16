var dataset = ee.Image("MERIT/Hydro_reduced/v1_0_1");

var visualization = {
  bands: 'wth',
  min: 0,
  max: 400
};

Map.setCenter(90.301, 23.052, 10);

Map.addLayer(dataset, visualization, "River width");
