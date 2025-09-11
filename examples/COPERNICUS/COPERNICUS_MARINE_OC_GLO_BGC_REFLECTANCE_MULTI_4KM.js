var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/REFLECTANCE_MULTI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));
var RRS = dataset.select('RRS412').mean();
var RRSVis = {
  min: 0.001,
  max: 0.018,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(RRS, RRSVis, 'Reflectance sensor');