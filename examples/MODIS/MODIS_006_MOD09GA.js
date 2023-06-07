var dataset = ee.ImageCollection('MODIS/006/MOD09GA')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var trueColor143 =
    dataset.select(['sur_refl_b01', 'sur_refl_b04', 'sur_refl_b03']);
var trueColor143Vis = {
  min: -100,
  max: 8000,
};
Map.setCenter(-7.03, 31.05, 2);
Map.addLayer(trueColor143, trueColor143Vis, 'True Color (143)');