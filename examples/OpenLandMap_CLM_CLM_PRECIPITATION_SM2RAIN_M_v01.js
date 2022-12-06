var dataset = ee.Image("OpenLandMap/CLM/CLM_PRECIPITATION_SM2RAIN_M/v01");

var visualization = {
  bands: ['jan'],
  min: 0.0,
  max: 380.0,
  palette: ['ecffbd', 'ffff00', '3af6ff', '467aff', '313eff', '0008ff']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Precipitation monthly in mm");