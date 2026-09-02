var dataset = ee.ImageCollection('NASA/VIIRS/002/AERDB_D3_VIIRS_NOAA20')
                  .filter(ee.Filter.date('2023-08-01', '2023-08-10'));

var aot = dataset.select('Aerosol_Optical_Thickness_550_Land_Ocean_Mean');
var aotVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', '00ff00', 'ffff00', 'ff0000']
};

Map.setCenter(0.0, 20.0, 2);
Map.addLayer(aot, aotVis, 'Aerosol Optical Thickness (550nm)');
