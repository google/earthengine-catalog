var imageVisParamNO2 = {
  'bands': ['NO2'],
  'min': 6.96e-11,
  'max': 4.42e-8,
};

var imageVisParamT = {
  'bands': ['T'],
  'min': 220,
  'max': 320,
  'palette': ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};

var geosCf = ee.ImageCollection('NASA/GEOS-CF/v2/ana/tavg1hr');

Map.setCenter(100, 20, 3);

var weeklyT =
    geosCf.select('T').filterDate('2025-08-04', '2025-08-11').median();
Map.addLayer(weeklyT, imageVisParamT, 'Weekly T', false, 1);

var NO2 = ee.Image('NASA/GEOS-CF/v2/ana/tavg1hr/20250804_1200z');
Map.addLayer(NO2, imageVisParamNO2, 'NO2', true, 1);
