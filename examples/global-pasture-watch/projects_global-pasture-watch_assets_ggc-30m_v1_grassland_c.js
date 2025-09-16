Map.setCenter(-49.265188, -16.602052, 4);

var domi_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/grassland_c"
)
var visParams = {"opacity":1, "min":1,"max":2,"palette":["ffcd73","ff9916"]};

var domi_grassland_2022 = domi_grassland.filterDate('2022-01-01', '2023-01-01').first();
Map.addLayer(
    domi_grassland_2022.selfMask(), 
    visParams, 'Dominant grassland class (2022)'
);

var domi_grassland_2000 = domi_grassland.filterDate('2000-01-01', '2001-01-01').first();
Map.addLayer(
    domi_grassland_2000.selfMask(), 
    visParams, 'Dominant grassland class (2000)'
);