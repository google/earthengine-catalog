var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/PLANKTON_OLCI_300M')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));

var CHL = dataset.select('CHL').mean();
var vis = {
  min: 0.027,
  max: 1.813,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(CHL, vis, 'CHL');