Map.setCenter(63.72366666, 38.30182604, 4);

var nat_semi_grassland = ee.ImageCollection(
  "projects/global-pasture-watch/assets/ggc-30m/v1/nat-semi-grassland_p"
)
var min_prob = 43 // Probability threshold
var visParams = {min: 0, max: 100, palette: 'f7f1e5,af8260,803d3b,322c2b'}

var nat_semi_grassland_2022 = nat_semi_grassland.filterDate('2022-01-01', '2023-01-01').first();
Map.addLayer(
    nat_semi_grassland_2022.mask(nat_semi_grassland_2022.gte(min_prob)), 
    visParams, 'Cultivated grassland prob. (2022)'
);

var nat_semi_grassland_2000 = nat_semi_grassland.filterDate('2000-01-01', '2001-01-01').first();
Map.addLayer(
    nat_semi_grassland_2000.mask(nat_semi_grassland_2000.gte(min_prob)), 
    visParams, 'Cultivated grassland prob. (2000)'
);