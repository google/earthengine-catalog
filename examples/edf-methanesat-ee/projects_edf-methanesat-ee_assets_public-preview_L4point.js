var dataset = ee.FeatureCollection("projects/edf-methanesat-ee/assets/public-preview/L4point");

// Add a `style` property with `pointSize` dependent on flux value.
dataset = dataset.map(function(feature) {
  var size = ee.Number(feature.get('flux')).divide(150).min(25);
  return feature.set('style', { pointSize: size, color: 'red'});
});
var datasetVis = dataset.style({styleProperty: 'style'});

Map.setCenter(-43.03, 37.48, 3);
Map.addLayer(datasetVis, null, 'Methane point sources flux in kg/h');