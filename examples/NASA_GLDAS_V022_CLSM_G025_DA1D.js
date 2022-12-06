var dataset = ee.ImageCollection('NASA/GLDAS/V022/CLSM/G025/DA1D')
                  .filter(ee.Filter.date('2010-06-01', '2010-06-02'));
var averageSurfaceSkinTemperatureK = dataset.select('AvgSurfT_tavg');
var averageSurfaceSkinTemperatureKVis = {
  min: 258,
  max: 316,
  palette: ['1303ff', '42fff6', 'f3ff40', 'ff5d0f'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(
    averageSurfaceSkinTemperatureK, averageSurfaceSkinTemperatureKVis,
    'Average Surface Skin Temperature [K]');
