var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP09GA')
                  .filter(ee.Filter.date('2014-05-01', '2014-05-31'));

var rgb = dataset.select(['M5', 'M4', 'M3']);
var rgbVis = {
  min: 0.0,
  max: 0.3
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(rgb, rgbVis, 'RGB');
