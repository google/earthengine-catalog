var grass_mask = ee.Image("projects/global-pasture-watch/assets/ggc-30m/v1/grassland_c/2022");

Map.setCenter(-50.66328, -14.08633, 10);

var EPSILON_MAX = 0.86;  // Recommended grassland LUEmax (gC/m^2/day/MJ)
var SCALE_FACTOR = 0.1;  // Scale factor integer to float
var N_DAYS = 15 // Number of accumulated days

var collection = ee.ImageCollection(
    'projects/global-pasture-watch/assets/ggpp-10m/v1-beta/nrt'
).filterDate('2026-07-01', '2026-07-15');

var ugpp = collection.median()
    .multiply(SCALE_FACTOR)
    .multiply(N_DAYS)
    .mask(grass_mask.eq(1))

// Calibrated GPP = LUEmax x uGPP (one multiplication).
var gpp = ugpp.multiply(EPSILON_MAX)

var vis = {min: 0, max: 20, palette: 'faccfa,f19d6b,828232,226061,011959'};

Map.addLayer(ugpp, vis, 'Accumulated uGPP (gC/m²/day), median');
Map.addLayer(gpp, vis, 'Accumulated GPP (gC/m²/day) with LUEmax = ' + EPSILON_MAX);
