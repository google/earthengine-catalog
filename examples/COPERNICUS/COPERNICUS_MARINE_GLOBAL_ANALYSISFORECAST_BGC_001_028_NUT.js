var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/NUT")
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));
var no3 = dataset.select('no3_depth1');
var no3Vis = {
  min: 0,
  max: 10,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(no3, no3Vis, 'Global BGC NUT Forecast');
