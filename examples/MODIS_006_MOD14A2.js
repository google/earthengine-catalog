var dataset = ee.ImageCollection('MODIS/006/MOD14A2')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var fireMask = dataset.select('FireMask');
var fireMaskVis = {
  min: 3.0,
  max: 8.0,
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(fireMask, fireMaskVis, 'Fire Mask');
