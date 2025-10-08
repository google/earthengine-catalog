var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/CAR")
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));
var ph = dataset.select('ph_depth1');
var phVis = {
  min: 8,
  max: 8.2,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(ph, phVis, 'Global BGC CAR Forecast');
