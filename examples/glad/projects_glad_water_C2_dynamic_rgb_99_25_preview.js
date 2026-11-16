var rgb = ee.Image('projects/glad/water/C2/dynamic_rgb_99_25')
Map.addLayer(rgb,{min:0,max:100})

var long = -66.95;
var lat = -2.75;
var radius = 25000;
var bounds = ee.Geometry.Point([long,lat]).buffer(radius).bounds()
Map.addLayer(bounds)
print(ui.Thumbnail({
  image: rgb.visualize({min: 0, max: 100}),
  params: {dimensions: '256x256', region: bounds, format: 'png'},
}));
