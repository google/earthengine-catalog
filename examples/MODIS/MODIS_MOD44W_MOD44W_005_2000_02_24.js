var dataset = ee.Image('MODIS/MOD44W/MOD44W_005_2000_02_24');
var waterMask = dataset.select('water_mask');
var waterMaskVis = {
  min: 0.0,
  max: 1,
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(waterMask, waterMaskVis, 'Water Mask');
