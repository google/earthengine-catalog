// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.FeatureCollection("projects/edf-methanesat-ee/assets/public-preview/L4point");

// Add a `style` property with `pointSize` dependent on flux value.
var minSize = 5;
dataset = dataset.map(function(feature) {
  var flux = ee.Number(feature.get('flux'));
  var size = ee.Algorithms.If(flux, flux.divide(150).min(minSize), minSize);
  return feature.set('style', { pointSize: size, color: '#ffdf00aa'});
});
var datasetVis = dataset.style({styleProperty: 'style'});

// Background
var background = ee.Image
  .rgb(256, 256, 256)
  .rename('vis-red', 'vis-green', 'vis-blue');
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