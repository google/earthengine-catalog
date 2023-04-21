var dataset = ee.Image('CSP/ERGo/1_0/Global/SRTM_CHILI');
var srtmChili = dataset.select('constant');
var srtmChiliVis = {
  min: 0.0,
  max: 255.0,
};
Map.setCenter(-105.8636, 40.3439, 11);
Map.addLayer(srtmChili, srtmChiliVis, 'SRTM CHILI');
