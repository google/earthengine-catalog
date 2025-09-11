var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/TRANSPARENCY_MULTI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));

var ZSD = dataset.select('ZSD');
var vis = {
  min: 5.712,
  max: 51.91,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(ZSD, vis, 'ZSD');
