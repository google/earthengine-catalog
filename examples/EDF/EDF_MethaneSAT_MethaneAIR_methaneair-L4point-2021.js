var dataset = ee.FeatureCollection("EDF/MethaneSAT/MethaneAIR/methaneair-L4point-2021");

// Add a `style` property with `pointSize` dependent on flux value.
dataset = dataset.map(function(feature) {
    var size = ee.Number(feature.get('Flux_kg_hr')).divide(150);
    return feature.set('style', { pointSize: size, color: 'red'});
  });
var datasetVis = dataset.style({styleProperty: 'style'});

// Center on one of the two available areas of interests.
// Map.setCenter(-109.6, 40, 9)
Map.setCenter(-103.71, 31.96, 9);
Map.addLayer(datasetVis, null, 'Methane point sources flux in kg/h');