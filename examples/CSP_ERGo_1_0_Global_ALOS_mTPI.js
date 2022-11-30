var dataset = ee.Image('CSP/ERGo/1_0/Global/ALOS_mTPI');
var alosMtpi = dataset.select('AVE');
var alosMtpiVis = {
  min: -200.0,
  max: 200.0,
  palette: ['0b1eff', '4be450', 'fffca4', 'ffa011', 'ff0000'],
};
Map.setCenter(-105.8636, 40.3439, 11);
Map.addLayer(alosMtpi, alosMtpiVis, 'ALOS mTPI');
