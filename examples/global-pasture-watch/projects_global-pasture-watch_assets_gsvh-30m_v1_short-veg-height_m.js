Map.setCenter(-49.265188, -16.602052, 4);

var short_veg_height_m = ee.ImageCollection("projects/global-pasture-watch/assets/gsvh-30m/v1/short-veg-height_m"),
    style = {"opacity":1,"bands":["height"],"min":0,"max":10,"palette":["#fcffa4","#f98d0a","#bb3755","#57106e","#000004"]};

var SCALE_FACTOR = 0.1
var svhVis = {min: 0, max: 10, palette: "fcffa4,f98d0a,bb3755,57106e,000004"}
var svh = ee.ImageCollection(
    "projects/global-pasture-watch/assets/gsvh-30m/v1/short-veg-height_m"
)

var svh2022 = svh.filterDate('2024-01-01', '2025-01-01').first().multiply(SCALE_FACTOR);
Map.addLayer(svh2022, svhVis, 'Median vegetation height (2024)');

var svh2000 = svh.filterDate('2000-01-01', '2001-01-01').first().multiply(SCALE_FACTOR);
Map.addLayer(svh2000, svhVis, 'Median vegetation height (2000)');