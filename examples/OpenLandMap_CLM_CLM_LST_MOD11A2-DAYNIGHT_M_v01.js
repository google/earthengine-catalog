var dataset = ee.Image("OpenLandMap/CLM/CLM_LST_MOD11A2-DAYNIGHT_M/v01");

var visualization = {
  bands: ['jan'],
  min: -40.5137,
  max: 1336.09,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Long-term Land Surface Temperature monthly day-night difference");