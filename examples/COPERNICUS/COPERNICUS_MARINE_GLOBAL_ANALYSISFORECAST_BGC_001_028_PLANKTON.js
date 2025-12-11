var dataset = ee.ImageCollection("COPERNICUS/MARINE/GLOBAL_ANALYSISFORECAST_BGC_001_028/PLANKTON")
                  .filter(ee.Filter.date('2024-01-01', '2025-01-01'));
var zooc = dataset.select('zooc_depth1');
var zoocVis = {
  min: 0,
  max: 3,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(zooc, zoocVis, 'Global BGC PLANKTON Forecast');
