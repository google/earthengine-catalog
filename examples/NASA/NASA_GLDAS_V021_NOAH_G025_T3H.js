var dataset = ee.ImageCollection('NASA/GLDAS/V021/NOAH/G025/T3H')
                  .filter(ee.Filter.date('2010-06-01', '2010-06-02'));
var averageSurfaceSkinTemperatureK = dataset.select('AvgSurfT_inst');
var averageSurfaceSkinTemperatureKVis = {
  min: 250.0,
  max: 300.0,
  palette: ['1303ff', '42fff6', 'f3ff40', 'ff5d0f'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(
    averageSurfaceSkinTemperatureK, averageSurfaceSkinTemperatureKVis,
    'Average Surface Skin Temperature [K]');
