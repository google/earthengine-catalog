var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP09GA')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-31'));
var rgb = dataset.select(['M5', 'M4', 'M3']);
var rgbVis = {
  min: 0.0,
  max: 3000.0,
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(rgb, rgbVis, 'RGB');
