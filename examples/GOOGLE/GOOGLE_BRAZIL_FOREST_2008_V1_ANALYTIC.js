// To access this dataset, fill out the form: https://forms.gle/jQmCbWgarjENQBYz6

var analytic = ee.Image('GOOGLE/BRAZIL_FOREST_2008/V1/ANALYTIC');

// Calculate NDVI using the Red (R) and Near-Infrared (N) bands.
var ndvi = analytic.normalizedDifference(['N', 'R']).rename('NDVI');

var ndviParams = {
  min: 0,
  max: 0.75,
  palette: ['white', 'green']
};

Map.setCenter(-55.0, -10.0, 6);
Map.addLayer(ndvi, ndviParams, 'NDVI (Forest Status 2008)');

// Display false color representation.
var nrgVis = {
  bands: ['N', 'R', 'G'],
  min: [156, 62, 53],
  max: [6408, 2584, 2211],
  gamma: [0.9, 0.9, 0.9]
};
Map.addLayer(analytic, nrgVis, 'Multispectral (NIR/R/G)');
