Map.setCenter(-55.50, -12.20, 8);

var epsilonMax = 0.86;  // Recommended grassland LUEmax (gC/m^2/day/MJ)

var collection = ee.ImageCollection(
    'projects/global-pasture-watch/assets/ggpp-10m/v1-beta/nrt'
);

// The 'ugpp' band stores uGPP scaled by 10 (16-bit integers) with no-data = -1.
var ugpp = collection.map(function(image) {
  return image.select('ugpp')
      .updateMask(image.select('ugpp').neq(-1))
      .multiply(0.1)
      .rename('ugpp_gC_m2_day');
});

// Calibrated GPP = LUEmax x uGPP (one multiplication).
var gpp = ugpp.map(function(image) {
  return image.multiply(epsilonMax).rename('gpp_gC_m2_day');
});

var vis = {min: 0, max: 20, palette: 'faccfa,f19d6b,828232,226061,011959'};

// Median over a recent period.
var ugppMedian = ugpp.filterDate('2026-06-27', '2026-09-20').median();
Map.addLayer(ugppMedian, vis, 'uGPP (gC/m²/day), median');

var gppMedian = gpp.filterDate('2026-06-27', '2026-09-20').median();
Map.addLayer(gppMedian, vis, 'GPP (gC/m²/day) with LUEmax = 0.86');
