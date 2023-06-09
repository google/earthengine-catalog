var dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/FNF')
                  .filterDate('2017-01-01', '2017-12-31');
var forestNonForest = dataset.select('fnf');
var forestNonForestVis = {
  min: 1,
  max: 3,
  palette: ['006400', 'feff99', '0000ff'],
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(forestNonForest, forestNonForestVis, 'Forest/Non-Forest');
