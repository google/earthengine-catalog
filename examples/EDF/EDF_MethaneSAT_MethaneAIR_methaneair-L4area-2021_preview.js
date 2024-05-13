var methaneAirArea = ee.Image("EDF/MethaneSAT/MethaneAIR/methaneair-L4area-2021")

// Visualization
var datasetVis = methaneAirArea.visualize({
  bands: ['flux'],
  min: 0,
  max: 24,
  palette: ['#070088','#a3069b','#cc4e64','#ffa826','#edfb59']
});

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
// Geometry to clip image only to RF06 area.
var region = ee.Geometry.Rectangle(-104.33, 31.42, -103.11, 32.52);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));