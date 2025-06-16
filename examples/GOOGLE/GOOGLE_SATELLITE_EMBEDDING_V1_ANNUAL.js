// Load collection.
var dataset = ee.ImageCollection('GOOGLE/SATELLITE_EMBEDDING/V1/ANNUAL');

// Point of interest.
var point = ee.Geometry.Point(-120.5122, 37.3596);

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

// Calculate dot product (cosine similarity) to highlight deviations
// between embedding vectors.
var dotProd = image1
    .multiply(image2)
    .reduce(ee.Reducer.sum())
    .multiply(-0.5) // scale, and flip sign so positive = more different
    .add(0.5);      // shift so that 0 = no change, 1 = change

// Add dot product to the map.
Map.addLayer(
  dotProd,
  {min: 0, max: 0.3},
  'Change between years (brighter=larger deviation)'
);

Map.centerObject(point, 12);
Map.setOptions('SATELLITE');
