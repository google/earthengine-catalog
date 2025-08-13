Map.setCenter(-49.265188, -16.602052, 4);

var ugppVis = {min: 0, max: 4000, palette: "faccfa,f19d6b,828232,226061,011959"}
var ugpp = ee.ImageCollection(
    "projects/global-pasture-watch/assets/ggpp-30m/v1/ugpp_m"
)

var ugpp2024 = ugpp.filterDate('2024-01-01', '2024-01-01').first();
Map.addLayer(ugpp2024, ugppVis, 'Uncalibrated GPP (2024)');

var ugpp2000 = ugpp.filterDate('2000-01-01', '2001-01-01').first();
Map.addLayer(ugpp2000, ugppVis, 'Cultivated grassland prob. (2000)');