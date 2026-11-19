var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ209GA')
                  .filter(ee.Filter.date('2026-10-11', '2026-10-12'));

var rgb = dataset.select(['M5', 'M4', 'M3']);
var rgbVis = {
  min: 0.0,
  max: 0.3,
};
Map.setCenter(-120.5, 37.5, 6);
Map.addLayer(rgb, rgbVis, 'RGB');
