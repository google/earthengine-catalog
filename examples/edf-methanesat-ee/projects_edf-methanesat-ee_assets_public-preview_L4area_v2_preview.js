// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var methaneSATArea = ee.ImageCollection("projects/edf-methanesat-ee/assets/public-preview/L4area_v2")
  .filterDate('2024-11-22', '2024-11-23');

// Visualization
var datasetVis = methaneSATArea.mosaic().visualize({
  bands: ['mean_flux'],
  min: 0,
  max: 625,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59'],
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle(-101.3, 26.5, -98, 29.5);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));