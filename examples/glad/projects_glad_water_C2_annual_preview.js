var annual = ee.ImageCollection('projects/glad/water/C2/annual')
var a25 = annual.filterDate('2025-01-01').first()
var min = 0;
var max = 100;
Map.addLayer(a25,{min:min,max:max},'wp 2025');

var long = 68.1281;
var lat = 24;
var radius = 40000;
var bounds = ee.Geometry.Point([long,lat]).buffer(radius).bounds();
Map.addLayer(bounds);
print(ui.Thumbnail(a25,{dimensions:"256x256",region:bounds.getInfo(),min:min,max:max}))
