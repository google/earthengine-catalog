var dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/FNF4')
                  .filterDate('2018-01-01', '2018-12-31');
var forestNonForest = dataset.select('fnf');
var forestNonForestVis = {
  min: 1,
  max: 4,
  palette: ['00b200','83ef62','ffff99','0000ff'],
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(forestNonForest, forestNonForestVis, 'Forest/Non-Forest');
