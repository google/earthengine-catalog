var dataset = ee.ImageCollection("COPERNICUS/MARINE/WAV/ANFC_0_083DEG_PT3H")
                  .filter(ee.Filter.date('2024-07-01', '2024-07-15'));
var significantWaveHeight = dataset.select('VHM0');
var significantWaveHeightVis = {
  min: 0,
  max: 10,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 1);
Map.addLayer(significantWaveHeight, significantWaveHeightVis, 'Significant Wave Height');