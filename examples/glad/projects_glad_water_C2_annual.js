var long = 59.8147;
var lat = 44.6193;
Map.setCenter(long,lat,7)

var annual = ee.ImageCollection('projects/glad/water/C2/annual')
Map.addLayer(annual,{min:0,max:100},'water percent time-series');
print(ui.Chart.image.series(annual,ee.Geometry.Point(long,lat)))

Map.addLayer(annual.toBands(),{bands:['2000_percent_water','2012_percent_water','2025_percent_water'],min:0,max:100},'water percent 2000-2012-2025');

var percent2025 = annual.filterDate('2025-01-01').first()
Map.addLayer(percent2025,{min:0,max:100},'water percent 2025');
