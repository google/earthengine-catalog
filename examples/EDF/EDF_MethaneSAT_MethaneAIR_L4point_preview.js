var dataset = ee.FeatureCollection("EDF/MethaneSAT/MethaneAIR/L4point");

// Add a `style` property with `pointSize` dependent on flux value.
dataset = dataset.map(function(feature) {
    var size = ee.Number(feature.get('flux')).divide(150).min(5);
    return feature.set('style', { pointSize: size, color: '#ffdf00aa'});
  })
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