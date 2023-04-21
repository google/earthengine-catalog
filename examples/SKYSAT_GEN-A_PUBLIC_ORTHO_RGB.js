var dataset = ee.ImageCollection('SKYSAT/GEN-A/PUBLIC/ORTHO/RGB');
var rgb = dataset.select(['R', 'G', 'B']);
var rgbVis = {
  min: 11.0,
  max: 190.0,
};
Map.setCenter(-70.892, 41.6555, 15);
Map.addLayer(rgb, rgbVis, 'RGB');
