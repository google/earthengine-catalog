var dataset = ee.ImageCollection('NCEP_RE/sea_level_pressure')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var seaLevelPressure = dataset.select('slp');
var seaLevelPressureVis = {
  min: 96500.0,
  max: 104500.0,
  palette: ['800080', '0000ab', '008000', 'ffff00', 'ffa500', 'ff0000'],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(seaLevelPressure, seaLevelPressureVis, 'Sea Level Pressure');
