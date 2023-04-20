var dataset = ee.ImageCollection('GLCF/GLS_TCC')
                  .filter(ee.Filter.date('2010-01-01', '2010-12-31'));
var treeCanopyCover = dataset.select('tree_canopy_cover');
var treeCanopyCoverVis = {
  min: 0.0,
  max: 100.0,
  palette: ['ffffff', 'afce56', '5f9c00', '0e6a00', '003800'],
};
Map.setCenter(-88.6, 26.4, 3);
Map.addLayer(treeCanopyCover, treeCanopyCoverVis, 'Tree Canopy Cover');
