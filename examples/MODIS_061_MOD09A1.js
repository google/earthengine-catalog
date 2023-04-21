var dataset = ee.ImageCollection('MODIS/061/MOD09A1')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var trueColor =
    dataset.select(['sur_refl_b01', 'sur_refl_b04', 'sur_refl_b03']);
var trueColorVis = {
  min: -100.0,
  max: 3000.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor, trueColorVis, 'True Color');
