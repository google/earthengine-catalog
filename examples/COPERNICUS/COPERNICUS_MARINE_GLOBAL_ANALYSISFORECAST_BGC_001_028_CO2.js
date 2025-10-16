var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/CO2")
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));
var spco2 = dataset.select('spco2_depth1');
var spco2Vis = {
  min: 20,
  max: 40,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(spco2, spco2Vis, 'Global BGC CO2 Forecast');
