var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/PRIMARY_PRODUCTION_MULTI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));
var PP = dataset.select('PP');
var PPVis = {
  min: 57.26,
  max: 1031.191,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(PP, PPVis, 'Primary Production');
