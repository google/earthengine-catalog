var dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/FNF4')
                  .filterDate('2018-01-01', '2018-12-31');
var forestNonForest = dataset.select('fnf');
var forestNonForestVis = {
  min: 1.0,
  max: 4.0,
  palette: ["00B200","83EF62","FFFF99","0000FF"],
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(forestNonForest, forestNonForestVis, 'Forest/Non-Forest');
