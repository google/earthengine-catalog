var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ243IA3')
                  .filter(ee.Filter.date('2023-06-01', '2023-06-10'));

var visualization = {
  bands: ['Albedo_BSA_I1'],
  min: [0.0],
  max: [0.3],
  palette: [
    '440154', // Deep purple
    '414487', // Blue
    '2a788e', // Teal
    '22a884', // Green
    '7ad151', // Yellow-green
    'fde725', // Bright yellow
  ],
};

Map.setCenter(-98.0, 38.0, 4);
Map.addLayer(dataset, visualization, 'Black-Sky Albedo (Band I1)');
