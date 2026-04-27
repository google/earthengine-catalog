Map.setCenter(-61.06,-5.25,3)

//Load image collection and select year 2024
var Collection = ee.ImageCollection('projects/ee-potapovpeter/assets/LATAM_WVSC/latam_v1')
   .filter(ee.Filter.eq('year', 2024));
var Year_2024 = Collection.first();

//Select and add to the map woody vegetation canopy cover 2024
var TCC2024 = Year_2024.select(['TCC']);
Map.addLayer(TCC2024.updateMask(TCC2024.gte(10)),{min:10,max:100,palette:'white, green'},'WVCC 2024', 1, 1)

//Select and add to the map woody vegetation canopy height 2024
var TCH2024 = Year_2024.select(['TCH']);
Map.addLayer(TCH2024.updateMask(TCH2024.gte(20)),{min:20,max:300,palette:'#8a35ac, #466be3, #28bceb, #32f298, #a4fc3c, #eecf3a, #fb7e21, #d02f05, #7a0403'},'WVCH 2024', 1, 1)

//Select and add to the map woody vegetation canopy change 2024
var Change2024 = Year_2024.select(['Change']);
Map.addLayer(Change2024.updateMask(Change2024.gte(1)),{min:1,max:4,palette:'#C20000, #FFB900, #0800F2, #66D964'},'Change 2024', 1, 1)
