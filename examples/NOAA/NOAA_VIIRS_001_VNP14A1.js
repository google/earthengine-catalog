var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP14A1').first();

var band_vis = {
  min: [1],
  max: [10000],
  palette: ['000000', '004400', '008800', '00bb00', '00ff00'],
  bands: ['MaxFRP'],
};

Map.setCenter(-1.94, 10.35, 10);
Map.addLayer(dataset, band_vis, 'Maximum Fire Radiative Power');
