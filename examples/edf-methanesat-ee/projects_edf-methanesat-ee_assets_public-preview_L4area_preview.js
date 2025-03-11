var methaneSATArea = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area")
  .filterDate('2024-06-01', '2025-01-31');

// Visualization
var datasetVis = methaneSATArea.mosaic().visualize({
  min: 0,
  max: 18,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59']
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle(-104.6, 30.5, -100.8, 33.2);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));