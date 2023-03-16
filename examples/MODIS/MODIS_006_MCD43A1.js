var dataset = ee.ImageCollection('MODIS/006/MCD43A1')
                  .filter(ee.Filter.date('2018-05-01', '2018-07-01'));
var defaultVisualization = dataset.select([
  'BRDF_Albedo_Parameters_Band1_iso', 'BRDF_Albedo_Parameters_Band4_iso',
  'BRDF_Albedo_Parameters_Band3_iso'
]);
var defaultVisualizationVis = {
  min: 0.0,
  max: 1400.0,
  gamma: 2.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(
    defaultVisualization, defaultVisualizationVis, 'Default visualization');
