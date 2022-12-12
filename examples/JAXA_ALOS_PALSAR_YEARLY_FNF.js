var dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/FNF')
                  .filterDate('2017-01-01', '2017-12-31');
var forestNonForest = dataset.select('fnf');
var forestNonForestVis = {
  min: 1.0,
  max: 3.0,
  palette: ['006400', 'FEFF99', '0000FF'],
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(forestNonForest, forestNonForestVis, 'Forest/Non-Forest');
