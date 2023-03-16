var dataset = ee.ImageCollection("FAO/GHG/1/DROSA_A");

var visualization = {
  bands: ['cropland'],
  min: 1.0,
  max: 60.0,
  palette: ['white', 'red']
};

Map.setCenter(108.0, -0.4, 6);

Map.addLayer(dataset, visualization, "Cropland area drained (Annual)");