var means = ee.ImageCollection('projects/glad/water/C2/monthMeans_99_25').toBands()
Map.addLayer(means.select(1,3,5),{min:0,max:100})

var long = 23;
var lat = -14.8;
var radius = 60000;
var bounds = ee.Geometry.Point([long,lat]).buffer(radius).bounds();
Map.addLayer(bounds);
print(ui.Thumbnail(means.select(1,3,5),{dimensions:"256x256",region:bounds.getInfo(),min:0,max:100}))
