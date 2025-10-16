var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/BIO")
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));
var nppv = dataset.select('nppv_depth1');
var nppvVis = {
  min: 1,
  max: 50,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(nppv, nppvVis, 'Global BGC BIO Forecast');
