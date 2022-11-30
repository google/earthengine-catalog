var dataset = ee.ImageCollection('USGS/LIMA/SR');
var antarctica = dataset.select(['B3', 'B2', 'B1']);
var antarcticaVis = {
  min: 0.0,
  max: 10000.0,
};
Map.setCenter(164.619, -77.99, 7);
Map.addLayer(antarctica, antarcticaVis, 'Antartica Imagery (RGB)');
