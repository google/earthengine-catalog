var dataset = ee.ImageCollection('EO1/HYPERION')
                  .filter(ee.Filter.date('2016-01-01', '2017-03-01'));
var rgb = dataset.select(['B050', 'B023', 'B015']);
var rgbVis = {
  min: 1000.0,
  max: 14000.0,
  gamma: 2.5,
};
Map.setCenter(162.0044, -77.3463, 9);
Map.addLayer(rgb.median(), rgbVis, 'RGB');
