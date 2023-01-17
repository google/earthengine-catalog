var dataset = ee.ImageCollection('NASA/SMAP/SPL3SMP_E/005')
                  .filter(ee.Filter.date('2017-04-01', '2017-04-30'));

var soilMositureSurface = dataset.select('soil_moisture_am');
var soilMositureSurfaceVis = {
  min: 0.0,
  max: 0.5,
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
};
Map.setCenter(-6.746, 46.529, 2);
Map.addLayer(soilMositureSurface, soilMositureSurfaceVis, 'Soil Mositure');
