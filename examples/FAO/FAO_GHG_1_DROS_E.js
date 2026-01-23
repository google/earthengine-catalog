var dataset = ee.ImageCollection('FAO/GHG/1/DROS-E');
var visualization = {
  bands: ['croplandco2'],
  min: 0,
  max: 40,
  palette: ['yellow', 'red']
};
Map.setCenter(108.0, -0.4, 6);
Map.addLayer(dataset, visualization, 'Cropland CO2 emissions (Annual)');