var filteredCollection = ee.ImageCollection('UK/NHM/BII/V1');

var meanImage = filteredCollection.select('b1').mean();

var colorPalette = [
  '#001a00', // Very Dark Green (Almost Black)
  '#002600', // Dark Green (Almost Black)
  '#003300', // Very Dark Green
  '#004d00', // Dark Green
  '#006400', // Dark Green
  '#008000', // Medium Green
  '#00a86b', // Green
  '#00c896', // Green
  '#00e8c1', // Light Green
  '#90EE90', // Very Light Green
  '#F0FFF0' // Almost White Green
];

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(meanImage, {min: 0, max: 1, palette: colorPalette}, 'BII');

