var dataset = ee.Image('UMD/hansen/global_forest_change_2023_v1_11');
var treeCoverVisParam = {
  bands: ['treecover2000'],
  min: 0,
  max: 100,
  palette: ['black', 'green']
};
Map.addLayer(dataset, treeCoverVisParam, 'tree cover 2000');

var treeLossVisParam = {
  bands: ['lossyear'],
  min: 0,
  max: 23,
  palette: ['yellow', 'red']
};
Map.addLayer(dataset, treeLossVisParam, 'tree loss year');
