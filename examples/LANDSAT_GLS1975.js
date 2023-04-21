var dataset = ee.ImageCollection('LANDSAT/GLS1975');
var falseColor = dataset.select(['30', '20', '10']);
var falseColorVis = {
  gamma: 1.6,
};
Map.setCenter(44.517, 25.998, 5);
Map.addLayer(falseColor, falseColorVis, 'False Color');