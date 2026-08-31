var classes = ee.Image('projects/glad/water/C2/dynamic_classes_99_25');
var min = 1;
var max = 12;
var palette = ['292929','ffffff','007dff','ff7d00','f000f0','00f000','999999','ad7d52','000000','404040','ebebeb','000000'];
Map.addLayer(classes,{min:min,max:max,palette:palette},'classes 99-25');

var long = -55.55;
var lat = -11.5;
var radius = 30000;
var bounds = ee.Geometry.Point([long,lat]).buffer(radius).bounds();
Map.addLayer(bounds);
print(ui.Thumbnail(classes,{dimensions:"256x256",region:bounds.getInfo(),min:min,max:max,palette:palette}));
