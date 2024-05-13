var dataset = ee.ImageCollection('NOAA/VIIRS/DNB/ANNUAL_V22')
                  .filter(ee.Filter.date('2022-01-01', '2023-01-01'));

var nighttime = dataset.select('maximum');
var nighttimeVis = {min: 0.0, max: 60.0};
Map.setCenter(-77.1056, 38.8904, 8);
Map.addLayer(nighttime, nighttimeVis, 'Nighttime');
