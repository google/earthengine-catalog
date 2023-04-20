var dataset = ee.Image('WHRC/biomass/tropical');
var liveWoodyBiomass = dataset.select('Mg');
var visParams = {
  min: 0.0,
  max: 350.0,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301'
  ],
};
Map.setCenter(-69.43, 0.35, 3);
Map.addLayer(liveWoodyBiomass, visParams, 'Aboveground Live Woody Biomass');
