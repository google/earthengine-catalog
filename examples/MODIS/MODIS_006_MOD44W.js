var dataset = ee.ImageCollection('MODIS/006/MOD44W')
                  .filter(ee.Filter.date('2015-01-01', '2015-05-01'));
var waterMask = dataset.select('water_mask');
var waterMaskVis = {
  min: 0.0,
  max: 1.0,
  palette: ['bcba99', '2d0491'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(waterMask, waterMaskVis, 'Water Mask');
