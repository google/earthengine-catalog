var dataset = ee.Image('CSP/ERGo/1_0/Global/SRTM_mTPI');
var srtmMtpi = dataset.select('elevation');
var srtmMtpiVis = {
  min: -200.0,
  max: 200.0,
  palette: ['0b1eff', '4be450', 'fffca4', 'ffa011', 'ff0000'],
};
Map.setCenter(-105.8636, 40.3439, 11);
Map.addLayer(srtmMtpi, srtmMtpiVis, 'SRTM mTPI');
