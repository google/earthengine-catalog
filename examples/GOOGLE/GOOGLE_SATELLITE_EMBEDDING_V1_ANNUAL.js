// Load collection.
var dataset = ee.ImageCollection('GOOGLE/SATELLITE_EMBEDDING/V1/ANNUAL');

// Point of interest.
var point = ee.Geometry.Point(-121.8036, 39.0372);

// Get embedding images for two years.
var image1 = dataset
      .filterDate('2023-01-01', '2024-01-01')
      .filterBounds(point)
      .first();

var image2 = dataset
      .filterDate('2024-01-01', '2025-01-01')
      .filterBounds(point)
      .first();

// Visualize three axes of the embedding space as an RGB.
var visParams = {min: -0.3, max: 0.3, bands: ['A01', 'A16', 'A09']};

Map.addLayer(image1, visParams, '2023 embeddings');
Map.addLayer(image2, visParams, '2024 embeddings');

// Calculate dot product as a measure of similarity between embedding vectors.
// Note for vectors with a magnitude of 1, this simplifies to the cosine of the
// angle between embedding vectors.
var dotProd = image1
    .multiply(image2)
    .reduce(ee.Reducer.sum());

// Add dot product to the map.
Map.addLayer(
  dotProd,
  {min: 0, max: 1, palette: ['white', 'black']},
  'Similarity between years (brighter = less similar)'
);

Map.centerObject(point, 12);
Map.setOptions('SATELLITE');