var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP21A1N')
                  .filter(ee.Filter.date('2022-11-01', '2022-12-01'));

var visualization = {
  bands: ['LST_1KM'],
  min: [150],
  max: [300],
  palette: [
    'a50026',
    'd73027',
    'f46d43',
    'fdae61',
    'fee08b',
    'ffffbf',
    'd9ef8b',
    'a6d96a',
    '66bd63',
    '1a9850',
    '006837',
  ]
};
Map.setCenter(41.2, 38.84, 3);
Map.addLayer(dataset, visualization, 'LST');