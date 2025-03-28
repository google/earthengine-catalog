var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP46A2')
                  .filter(ee.Filter.date('2013-01-01', '2013-03-01'));

var nighttime = dataset.select('Gap_Filled_DNB_BRDF_Corrected_NTL');
var nighttimeVis = {min: 0.0, max: 1.0};

Map.setCenter(-77.1056, 38.8904, 3);
Map.addLayer(nighttime, nighttimeVis, 'Nighttime');
