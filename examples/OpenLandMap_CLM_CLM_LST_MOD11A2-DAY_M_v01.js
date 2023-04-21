var dataset = ee.Image("OpenLandMap/CLM/CLM_LST_MOD11A2-DAY_M/v01");

var visualization = {
  bands: ['jan'],
  min: 11989.0,
  max: 16700.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Long-term Land Surface Temperature daytime monthly mean");