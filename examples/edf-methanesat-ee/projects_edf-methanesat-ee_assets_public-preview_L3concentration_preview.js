var methaneSATArea = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L3concentration")
  .filterDate('2024-06-01', '2025-01-31');

// Visualization
var datasetVis = methaneSATArea.mosaic().visualize({
  bands: ['XCH4'],
  min: 1870,
  max: 2030,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59']
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle(-104.8, 30.3, -100.8, 33.5);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));