Map.setCenter(-56.0780, -13.8429, 4);

var cultiv_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/cultiv-grassland_p"
)
var min_prob = 32 // Probability threshold
var visParams = {min: 0, max: 100, palette: 'f5f5f5,fdaf27,ae7947,3a2200'}

var cultiv_grassland_2020 = cultiv_grassland.filterDate('2022-01-01', '2023-01-01').first();
Map.addLayer(
    cultiv_grassland_2020.mask(cultiv_grassland_2020.gte(min_prob)), 
    visParams, 'Cultivated grassland prob. (2020)'
);

var cultiv_grassland_2000 = cultiv_grassland.filterDate('2000-01-01', '2001-01-01').first();
Map.addLayer(
    cultiv_grassland_2000.mask(cultiv_grassland_2000.gte(min_prob)), 
    visParams, 'Cultivated grassland prob. (2000)'
);