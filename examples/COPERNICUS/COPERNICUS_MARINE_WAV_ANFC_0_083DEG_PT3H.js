var dataset = ee.ImageCollection("COPERNICUS/MARINE/WAV_ANFC_0_083DEG_PT3H")
                  .filter(ee.Filter.date('2024-07-01', '2024-07-15'));
var elevation = dataset.select('VMHO');
var elevationVis = {
  min: -2.0,
  max: 1.5,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};
Map.setCenter(-140.5, 52.2, 2);
Map.addLayer(elevation, elevationVis, 'Sea Surface Height');
