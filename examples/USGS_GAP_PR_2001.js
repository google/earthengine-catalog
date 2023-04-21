var dataset = ee.Image('USGS/GAP/PR/2001');

var visualization = {
  bands: ['landcover'],
  min: 1.0,
  max: 70.0,
};

Map.setCenter(-66.51, 18.23, 8);

Map.addLayer(dataset, visualization, 'GAP Purto Rico');
