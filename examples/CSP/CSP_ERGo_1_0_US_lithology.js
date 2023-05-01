var dataset = ee.Image('CSP/ERGo/1_0/US/lithology');
var lithology = dataset.select('b1');
var lithologyVis = {
  min: 0.0,
  max: 20.0,
  palette: [
    '356eff', 'acb6da', 'd6b879', '313131', 'eda800', '616161', 'd6d6d6',
    'd0ddae', 'b8d279', 'd5d378', '141414', '6db155', '9b6d55', 'feeec9',
    'd6b879', '00b7ec', 'ffda90', 'f8b28c'
  ],
};
Map.setCenter(-105.8636, 40.3439, 11);
Map.addLayer(lithology, lithologyVis, 'Lithology');
