var indmonth = ee.ImageCollection('projects/glad/water/C2/individualMonths').filterDate('2025-07-01').first()
Map.addLayer(indmonth,{min:0,max:100},'indmonth')

var long = 76.37;
var lat = 62.0;
var radius = 13000;
var bounds = ee.Geometry.Point([long,lat]).buffer(radius).bounds();
Map.addLayer(bounds);
print(ui.Thumbnail(indmonth,{dimensions:"256x256",region:bounds.getInfo(),min:0,max:100}))
