var dataset = ee.Image('USGS/GAP/HI/2001');

var visualization = {
  bands: ['landcover'],
  min: 1.0,
  max: 37.0,
};

Map.setCenter(-157.0, 20.1, 7);

Map.addLayer(dataset, visualization, 'GAP Hawaii');
