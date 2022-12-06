var dataset = ee.ImageCollection('MODIS/061/MOD14A1')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var fireMaskVis = {
  min: 0.0,
  max: 6000.0,
  bands: ['MaxFRP', 'FireMask', 'FireMask'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(dataset, fireMaskVis, 'Fire Mask');
