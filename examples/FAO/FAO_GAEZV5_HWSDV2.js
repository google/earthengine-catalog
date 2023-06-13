dataset = ee.ImageCollection('FAO/GAEZv5/HWSDv2');
var visualization = {
  bands: ['DominantSoilType'],
  min: 1,
  max: 34,
  palette: ['ffffbe','730000','f79804','f2f2f2','40c0e9','fe0000','4b3dac','f5d4a1','8083d9','cf9804','914d35','fef400','febe00','00fefd','bd6446','fe00fa','ff8721','d4d4d4','fef6a4','706b66','383838','ca937f','d1d1d1','fa8484','ffbebe','ffa77f','fec2c2','f77d3a','0cd900','fee3a4','f9c2fe','91009d','c930fd','4752dc']
};
Map.setCenter(108.0, -0.4, 6);
Map.addLayer(dataset, visualization, 'GAEZ5-HWSDv2');