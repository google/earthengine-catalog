var dataset = ee.ImageCollection('MODIS/006/MODOCGA')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var falseColor =
    dataset.select(['sur_refl_b11', 'sur_refl_b10', 'sur_refl_b09']);
var falseColorVis = {
  min: 0.0,
  max: 2000.0,
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(falseColor, falseColorVis, 'False Color');
