var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/GLOBAL_SEA_SURFACE/REP_DAILY')
        .filter(ee.Filter.date('2023-12-16', '2023-12-17'));
var SOS = dataset.select('sos');
var SOSVis = {
  min: 27.869,
  max: 36.981,
  palette:
      ["040613","121328","3F59A5","3E80C0","3EADCB","8CCBD6","EAFDFD"],
};
Map.setCenter(71, 52, 2);
Map.addLayer(SOS, SOSVis, 'SOS');