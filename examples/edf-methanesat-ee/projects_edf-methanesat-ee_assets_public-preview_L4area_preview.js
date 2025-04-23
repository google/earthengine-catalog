// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var methaneSATArea = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area")
  .filterDate('2024-12-25', '2024-12-26');

// Visualization
var colorRange = [
  "#F9ED3B", "#F7E33A", "#F5D838", "#F1C335", "#EEB934", "#ECAE32","#EB9E2F",
  "#EA8D2C", "#EC8129", "#F16823", "#D85627", "#BF442C", "#983623", "#70281A"
];

var datasetVis = methaneSATArea.mosaic().visualize({
  min: 0,
  max: 625,
  palette: colorRange,
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle(-101.7, 26.80, -98.03, 29.27);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));