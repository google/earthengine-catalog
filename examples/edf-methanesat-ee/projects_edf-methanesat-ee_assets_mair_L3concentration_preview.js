// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var methaneAIRArea = ee.ImageCollection("projects/edf-methanesat-ee/assets/mair/L3concentration")
  .filterDate('2025-07-11', '2025-07-12');

// Visualization
var datasetVis = methaneAIRArea.mosaic().visualize({
  bands: ['XCH4'],
  min: 1870,
  max: 2030,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59']
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
var region = ee.Geometry.Rectangle(-95.593, 30.626, -92.681, 33.739);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));