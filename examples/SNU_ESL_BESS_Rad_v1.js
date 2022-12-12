var dataset = ee.ImageCollection("SNU/ESL/BESS/Rad/v1");

var visualization = {
  bands: ['PAR_Daily'],
  min: 0.0,
  max: 200.0,
};

Map.setCenter(0.0, 0.0, 1);

Map.addLayer(
    dataset, visualization,
    "Surface downwelling photosynthetic radiative flux");
