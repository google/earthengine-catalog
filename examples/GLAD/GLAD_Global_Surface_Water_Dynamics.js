var rgb = ee.Image('projects/glad/water/C2/dynamic_rgb_99_25')
Map.addLayer(rgb,{min:0,max:100},'dynamics 1999-2025')

var long = -55;
var lat = -2.1;
Map.setCenter(long,lat,9)
