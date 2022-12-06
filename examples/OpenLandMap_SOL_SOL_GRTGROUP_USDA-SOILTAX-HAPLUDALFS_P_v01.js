var dataset = ee.Image("OpenLandMap/SOL/SOL_GRTGROUP_USDA-SOILTAX-HAPLUDALFS_P/v01");

var visualization = {
  bands: ['grtgroup'],
  min: 0.0,
  max: 35.0,
  palette: ['ffffb2', 'fecc5c', 'fd8d3c', 'f03b20', 'bd0026']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Hapludalfs");