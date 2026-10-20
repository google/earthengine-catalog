var long = -114.098;
var lat = 36.137;
Map.setCenter(long,lat,11)

var indmonths = ee.ImageCollection('projects/glad/water/C2/individualMonths')
print(indmonths)
//as ImageCollection: nice for charting
Map.addLayer(indmonths,{min:0,max:100},'indmonths time-series')
print(ui.Chart.image.series(indmonths,ee.Geometry.Point(long,lat)))

//as Image: combining different dates
Map.addLayer(indmonths.filter(ee.Filter.calendarRange(7,7,'month')).toBands(),{bands:['2000_07_percent_percent_water','2010_07_percent_percent_water','2013_07_percent_percent_water'],min:0,max:100},'July time-series image')

//selecting an individual month
Map.addLayer(indmonths.filterDate('2025-05-01'),{min:0,max:100},'May 2025')

//reducing to find max, min, and median of dataset
Map.addLayer(ee.Image([indmonths.reduce('min'),indmonths.reduce('median'),indmonths.reduce('max')]),{min:0,max:100},'min-median-max')
