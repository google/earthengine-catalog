var dataset = ee.ImageCollection('AHN/AHN4');
var elevation = dataset.select('dsm');
var elevationVis = {
  min: -5.0,
  max: 30.0,
};
Map.setCenter(5.76583, 51.855276, 16);
Map.addLayer(elevation, elevationVis, 'AHN4 dsm');