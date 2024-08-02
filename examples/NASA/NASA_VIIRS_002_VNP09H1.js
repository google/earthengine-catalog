var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP09H1')
                  .filter(ee.Filter.date('2017-05-01', '2017-06-30'));
var rgb = dataset.select(['SurfReflect_I1', 'SurfReflect_I2', 'SurfReflect_I3']);
var rgbVis = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(rgb, rgbVis, 'RGB');
