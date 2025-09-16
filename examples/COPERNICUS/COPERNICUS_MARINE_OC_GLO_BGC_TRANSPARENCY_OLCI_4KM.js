var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/TRANSPARENCY_OLCI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));

var KD490 = dataset.select('KD490');
var vis = {
  min: 0.021,
  max: 0.212,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(KD490, vis, 'KD490');
