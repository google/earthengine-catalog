var dataset = ee.ImageCollection(
    "UMD/GLAD/PRIMARY_HUMID_TROPICAL_FORESTS/v1").mosaic().selfMask();

var visualization = {
  bands: ['Primary_HT_forests'],
  min: 1.0,
  max: 1.0,
  palette: ['008000']
};

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(dataset, visualization, "Primary HT forests");
