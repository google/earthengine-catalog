var dataset = ee.FeatureCollection("EDF/MethaneSAT/MethaneAIR/methaneair-L4point-2021");

// Add a `style` property with `pointSize` dependent on flux value.
dataset = dataset.map(function(feature) {
    var size = ee.Number(feature.get('Flux_kg_hr')).divide(150);
    return feature.set('style', { pointSize: size, color: '#ffdf00aa'});
  })
var datasetVis = dataset.style({styleProperty: 'style'});

// Background
var background = ee.Image
  .rgb(256, 256, 256)
  .rename('vis-red', 'vis-green', 'vis-blue');
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