// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var dataset = ee.FeatureCollection("projects/edf-methanesat-ee/assets/public-preview/L4point");

// Add a `style` property with `pointSize` dependent on flux value.
var minSize = 25;
dataset = dataset.map(function(feature) {
  var flux = ee.Number(feature.get('flux'));
  var size = ee.Algorithms.If(flux, flux.divide(150).min(minSize), minSize);
  return feature.set('style', { pointSize: size, color: 'red'});
});
var datasetVis = dataset.style({styleProperty: 'style'});

Map.setCenter(-43.03, 37.48, 3);
Map.addLayer(datasetVis, null, 'Methane point sources flux in kg/h');