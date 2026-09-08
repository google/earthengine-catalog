var classes = ee.Image('projects/glad/water/C2/dynamic_classes_99_25');
var min = 1;
var max = 12;
var palette = ['292929','ffffff','007dff','ff7d00','f000f0','00f000','999999','ad7d52','000000','404040','ebebeb','000000'];
Map.addLayer(classes,{min:min,max:max,palette:palette},'classes 99-25');

var long = -61.5;
var lat = -30.5;
Map.setCenter(long,lat,9)
