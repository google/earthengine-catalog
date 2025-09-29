var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/NRT_DAILY')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));
var NRT = dataset.select('dos');
var NRTVis = {
  min: 1020.41,
  max: 1027.596,
  palette:
      ["040613","121328","3F59A5","3E80C0","3EADCB","8CCBD6","EAFDFD"],
};
Map.setCenter(71, 52, 2);
Map.addLayer(NRT, NRTVis, 'DOS');