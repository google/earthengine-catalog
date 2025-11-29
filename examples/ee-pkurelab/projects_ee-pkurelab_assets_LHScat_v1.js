var visParams_signals = {
  min: -2000,
  max: 500,
  palette: ['green', 'yellow', 'red','firebrick']  
};

var visParams_RMSE = {
  min: 0,
  max: 2,
  palette: ['green', 'yellow', 'red','firebrick']  
};

var visParams_Pearsonr = {
  min: -1,
  max: 1,
  palette: ['green', 'yellow', 'red','firebrick']  
};

var start_date = "2020-03-01";
var end_date = "2020-04-01";
var LHScat = ee.ImageCollection("projects/ee-pkurelab/assets/LHScat_v1");
var signals_withdate = LHScat.filterDate(start_date,end_date);
var RMSE = ee.Image("projects/ee-pkurelab/assets/LHScat_v1/RMSE");
var Pearsonr = ee.Image("projects/ee-pkurelab/assets/LHScat_v1/Pearsonr");
Map.addLayer(signals_withdate,visParams_signals);
Map.addLayer(RMSE,visParams_RMSE);
Map.addLayer(Pearsonr,visParams_Pearsonr);