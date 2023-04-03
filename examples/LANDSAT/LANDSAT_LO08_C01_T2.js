var dataset = ee.ImageCollection("LANDSAT/LO08/C01/T2");

var visualization = {
  bands: ['B4', 'B3', 'B2'],
  min: 0.0,
  max: 30000.0,
};

Map.setCenter(27.54, 63.34, 4);

Map.addLayer(dataset, visualization, "True Color (432)");
