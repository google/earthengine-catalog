var dataset = ee.ImageCollection("LANDSAT/LO08/C01/T1_RT");

var visualization = {
  bands: ['B4', 'B3', 'B2'],
  min: 0.0,
  max: 30000.0,
};

Map.setCenter(15.05, 18.18, 4);

Map.addLayer(dataset, visualization, "True Color (432)");
