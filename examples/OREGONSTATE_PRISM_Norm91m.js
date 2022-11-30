var dataset = ee.ImageCollection('OREGONSTATE/PRISM/Norm91m');
var precipitation = dataset.select('ppt');
var precipitationVis = {
  min: 0.0,
  max: 300.0,
  palette: ['red', 'yellow', 'green', 'cyan', 'purple'],
};
Map.setCenter(-100.55, 40.71, 0);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
