var means = ee.ImageCollection('projects/glad/water/C2/monthMeans_99_25').toBands()
Map.addLayer(means.select(1,3,5),{min:0,max:100},'Feb-Apr-Jun')

var long = 23;
var lat = -14.8;
Map.setCenter(long,lat,9)
