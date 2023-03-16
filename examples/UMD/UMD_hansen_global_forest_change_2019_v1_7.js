var dataset = ee.Image('UMD/hansen/global_forest_change_2019_v1_7');
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
  max: 19,
  palette: ['yellow', 'red']
};
Map.addLayer(dataset, treeLossVisParam, 'tree loss year');
