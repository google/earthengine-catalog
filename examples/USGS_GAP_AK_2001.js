var dataset = ee.Image('USGS/GAP/AK/2001');

var visualization = {
  bands: ['landcover'],
  min: 1.0,
  max: 143.0,
};

Map.setCenter(-151.97, 63.68, 4);

Map.addLayer(dataset, visualization, 'GAP Alaska');
