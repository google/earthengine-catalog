var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ213A1')
                  .filter(ee.Filter.date('2026-10-21', '2026-11-06'));

var trueColorVis = {
  bands: ['red_reflectance', 'green_reflectance', 'blue_reflectance'],
  min: 0.0,
  max: 0.3,
  gamma: 1.4,
};

var ndviVis = {
  min: 0.0,
  max: 0.9,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301',
  ],
};

Map.setCenter(-98.0, 17.6, 6);
Map.addLayer(dataset, trueColorVis, 'True Color (RGB)');
Map.addLayer(dataset.select('NDVI'), ndviVis, 'NDVI');
