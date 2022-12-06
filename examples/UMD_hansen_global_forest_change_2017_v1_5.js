var dataset = ee.Image('UMD/hansen/global_forest_change_2017_v1_5');
var treeCanopyCover = dataset.select('treecover2000');
var treeCanopyCoverVis = {
  min: 0.0,
  max: 100.0,
  palette:
      ['3d3d3d', '080a02', '080a02', '080a02', '106e12', '37a930', '03ff17'],
};
Map.setCenter(-60.5, -20.0, 2);
Map.addLayer(treeCanopyCover, treeCanopyCoverVis, 'Tree Canopy Cover');
