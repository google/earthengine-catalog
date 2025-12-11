var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/OPTICS")
                  .filter(ee.Filter.date('2024-01-01', '2025-01-01'));
var kd = dataset.select('kd_depth1');
var kdVis = {
  min: 0,
  max: 0.1,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(kd, kdVis, 'Global BGC OPTICS Forecast');
