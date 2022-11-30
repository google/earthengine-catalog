var dataset = ee.Image('JRC/GHSL/P2016/BUILT_LDSMT_GLOBE_V1');
var builtUpMultitemporal = dataset.select('built');
var visParams = {
  min: 1.0,
  max: 6.0,
  palette: ['0c1d60', '000000', '448564', '70daa4', '83ffbf', 'ffffff'],
};
Map.setCenter(8.9957, 45.5718, 12);
Map.addLayer(builtUpMultitemporal, visParams, 'Built-Up Multitemporal');
