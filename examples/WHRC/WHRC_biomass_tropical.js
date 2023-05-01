var dataset = ee.Image('WHRC/biomass/tropical');
// Show results only over land.
var landMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var liveWoodyBiomass = dataset.updateMask(landMask);

var visParams = {
  min: 0,
  max: 350,
  palette: [
    'ffffff', 'ce7e45', 'df923d', 'f1b555', 'fcd163', '99b718', '74a901',
    '66a000', '529400', '3e8601', '207401', '056201', '004c00', '023b01',
    '012e01', '011d01', '011301'
  ],
};
Map.addLayer(
    liveWoodyBiomass, visParams, 'Aboveground Live Woody Biomass (Mg/ha)');

Map.setCenter(-69.4, 0.3, 3);
Map.setOptions('SATELLITE');
