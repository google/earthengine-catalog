var dataset =
    ee.ImageCollection('COPERNICUS/MARINE/OC_GLO_BGC/OPTICS_MULTI_4KM')
        .filter(ee.Filter.date('2025-03-01', '2025-06-01'));
var CDM = dataset.select('CDM');
var CDMVis = {
  min: 0.003,
  max: 0.109,
  palette:
      ['D7F9D0', '91CA85', '5AB05D', '129450', '0F7347', '195437', '122414'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(CDM, CDMVis, 'CDM');
