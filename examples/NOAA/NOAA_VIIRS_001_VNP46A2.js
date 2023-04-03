var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP46A2').filter(
  ee.Filter.date('2013-01-01', '2013-07-01'));

// Bidirectional Reflectance Distribution Function (BRDF)
var brdf = dataset.select('DNB_BRDF_Corrected_NTL');
var brdfVis = {
  min: 0,
  max: 100,
  palette: ['black', 'purple', 'cyan', 'green', 'yellow', 'red', 'white'],
};

Map.setCenter(-79.4, 43.1, 8);
// Day/Night Band (DNB)
// NightTime Light (NTL)
Map.addLayer(brdf, brdfVis, 'DNB_BRDF_Corrected_NTL');
