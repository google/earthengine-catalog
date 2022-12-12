var dataset = ee.ImageCollection("LANDSAT/LT08/C01/T2");

var visualization = {
  bands: ['B10', 'B11'],
  min: 0.0,
  max: 30000.0,
};

Map.setCenter(99.46, 68.91, 4);

Map.addLayer(dataset, visualization, "Thermal Infrared");
