var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/PFT")
                  .filter(ee.Filter.date('2024-01-01', '2025-01-01'));
var chl = dataset.select('chl_depth1');
var chlVis = {
  min: 0,
  max: 1,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(chl, chlVis, 'Global BGC PFT Forecast');
