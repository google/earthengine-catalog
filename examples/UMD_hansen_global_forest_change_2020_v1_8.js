var dataset = ee.Image('UMD/hansen/global_forest_change_2020_v1_8');
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
  max: 20,
  palette: ['yellow', 'red']
};
Map.addLayer(dataset, treeLossVisParam, 'tree loss year');
