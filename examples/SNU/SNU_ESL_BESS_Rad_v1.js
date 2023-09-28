var dataset = ee.ImageCollection('SNU/ESL/BESS/Rad/v1');

var visParams = {
  bands: ['PAR_Daily'],
  min: 0,
  max: 70,
  palette: ['black', 'purple', 'blue', 'yellow', 'orange', 'red']
};

Map.setCenter(2.1, 24.9, 3);

Map.addLayer(
    dataset, visParams,
    'Surface downwelling photosynthetic radiative flux (W/m^2)');
