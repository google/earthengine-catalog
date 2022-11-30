var dataset = ee.Image("OpenLandMap/PNV/PNV_FAPAR_PROBA-V_D/v01");

var visualization = {
  bands: ['jan'],
  min: 0.0,
  max: 220.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Potential FAPAR monthly");