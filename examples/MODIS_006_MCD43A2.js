var dataset = ee.ImageCollection('MODIS/006/MCD43A2')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var defaultVisualization = dataset.select('Snow_BRDF_Albedo');
var defaultVisualizationVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(
    defaultVisualization, defaultVisualizationVis, 'Default visualization');
