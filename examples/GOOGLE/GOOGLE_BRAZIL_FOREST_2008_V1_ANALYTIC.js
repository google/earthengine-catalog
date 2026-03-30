var analytic = ee.Image("GOOGLE/BRAZIL_FOREST_2008/V1/ANALYTIC");

// Calculate NDVI using the Red (R) and Near-Infrared (N) bands
var ndvi = analytic.normalizedDifference(['N', 'R']).rename('NDVI');

var ndviParams = {
  min: 0,
  max: 0.8,
  palette: ['white', 'green']
};

Map.setCenter(-55.0, -10.0, 6);
Map.addLayer(ndvi, ndviParams, 'NDVI (Forest Status 2008)');

// Add analytic image as well
Map.addLayer(analytic, {bands: ['N', 'R', 'G'], min: 0, max: 0.8}, 'Multispectral (NIR/R/G)');
