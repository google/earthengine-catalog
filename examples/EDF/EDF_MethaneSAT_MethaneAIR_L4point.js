var dataset = ee.FeatureCollection("EDF/MethaneSAT/MethaneAIR/L4point");

// Add a `style` property with `pointSize` dependent on flux value.
dataset = dataset.map(function(feature) {
  var size = ee.Number(feature.get('flux')).divide(150).min(25);
  return feature.set('style', { pointSize: size, color: 'red'});
});
var datasetVis = dataset.style({styleProperty: 'style'});

// Center on one of the available areas of interests.
Map.setCenter(-102.5, 31.85, 8);
Map.addLayer(datasetVis, null, 'Methane point sources flux in kg/h');