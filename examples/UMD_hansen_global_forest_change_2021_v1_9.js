var dataset = ee.Image('UMD/hansen/global_forest_change_2021_v1_9');
var treeCoverVisParam = {
  bands: ['treecover2000'],
  min: 0,
  max: 100,
  palette: ['black', 'green']
};
Map.addLayer(dataset, treeCoverVisParam, 'tree cover');

var treeLossVisParam = {
  bands: ['lossyear'],
  min: 0,
  max: 21,
  palette: ['yellow', 'red']
};
Map.addLayer(dataset, treeLossVisParam, 'tree loss year');
