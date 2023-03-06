var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP46A2');
print(dataset.first())
var brdf = dataset.select('DNB_BRDF_Corrected_NTL');
var brdfVis = {
  min: 0.0,
  max: 100.0,
  palette: ['red', 'yellow', 'green', 'cyan', 'purple'],
};
Map.setCenter(-100.55, 40.71, 4);
Map.addLayer(brdf, brdfVis, 'DNB_BRDF_Corrected_NTL');