var collection = ee.ImageCollection('NASA/NISAR/L3_SME2_PROVISIONAL_V1')
    .filterDate('2025-11-20', '2025-11-30');

var visParams = {
  min: 0.0,
  max: 0.5,
  bands: ['soilMoisture'],
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303']
};

Map.setCenter(140.0, 35.5, 6);
Map.addLayer(collection, visParams, 'NISAR Soil Moisture Provisional V1');

