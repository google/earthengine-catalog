var dataset = ee.Image("OpenLandMap/SOL/SOL_BULKDENS-FINEEARTH_USDA-4A1H_M/v02");

var visualization = {
  bands: ['b0'],
  min: 5.0,
  max: 185.0,
  palette: ['5e3c99', 'b2abd2', 'f7e0b2', 'fdb863', 'e63b01']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Soil bulk density in x 10 kg / m3");