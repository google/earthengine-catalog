var imageVisParamNO2 = {
  'bands': ['NO2'],
  'min': 6.96e-11,
  'max': 4.42e-8,
};

var geosCf = ee.ImageCollection('NASA/GEOS-CF/v2/ana/htf');

Map.setCenter(100, 20, 3);

var NO2 = ee.Image('NASA/GEOS-CF/v2/ana/htf/20250804_1200z');
Map.addLayer(NO2, imageVisParamNO2, 'NO2', true, 1);