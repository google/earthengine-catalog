// Load the Tallo database using the BigQuery connector.
var dataset = ee.FeatureCollection.loadBigQueryTable(
  'earth-engine-public-data.tallo.tallo_v1'
);

var tallTrees = dataset.filter(ee.Filter.gte('height_m', 30.0));

Map.setCenter(0, 20, 2);
Map.addLayer(dataset, {color: '228b22'}, 'All Tallo Trees');
Map.addLayer(tallTrees, {color: 'ff0000'}, 'Trees >= 30m');
