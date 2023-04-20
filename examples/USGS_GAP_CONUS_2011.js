var dataset = ee.Image('USGS/GAP/CONUS/2011');

var visualization = {
  bands: ['landcover'],
  min: 1.0,
  max: 584.0,
};

Map.setCenter(-98.58, 38.14, 4);

Map.addLayer(dataset, visualization, 'GAP CONUS');
