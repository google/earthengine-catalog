var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ209H1')
                  .filter(ee.Filter.date('2026-09-30', '2026-10-08'));

var falseColor =
    dataset.select(['SurfReflect_I3', 'SurfReflect_I2', 'SurfReflect_I1']);
var falseColorVis = {
  min: 0.0,
  max: 0.3,
  gamma: 1.4,
};
Map.setCenter(-162.64, -0.26, 4);
Map.addLayer(falseColor, falseColorVis, 'False Color (I3, I2, I1)');
