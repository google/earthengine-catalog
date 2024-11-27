var ms_grid3c = ee.ImageCollection(
  'projects/ornl-mapspace/assets/grid_3c');

var labelVis = {bands: 'label',min: 10, max: 30, palette: ['3eca76','cf6aa6','e6e5d8']};

var lon = 8.78;
var lat = 34.5;

Map.setCenter(lon, lat, 4);
Map.addLayer(ms_grid3c, labelVis)
