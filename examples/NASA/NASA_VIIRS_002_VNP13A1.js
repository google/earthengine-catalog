var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP13A1')
                  .filter(ee.Filter.date('2017-05-01', '2017-06-30'));
var rgb = dataset.select(['EVI']);
var rgbVis = {
  min: 0.0,
  max: 1.0,
  palette: ['000000', '004400', '008800', '00bb00', '00ff00'],
};
Map.setCenter(17.93, 7.71, 6);
Map.addLayer(rgb, rgbVis, 'RGB');
