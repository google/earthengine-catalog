var dataset = ee.ImageCollection('FAO/GHG/1/DROSE_A');

var visualization = {
  bands: ['croplandc'],
  min: 0,
  max: 1,
  palette: ['yellow', 'red']
};

Map.setCenter(108.0, -0.4, 6);

Map.addLayer(dataset, visualization, 'Cropland C emissions (Annual)');