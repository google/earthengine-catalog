var dataset = ee.ImageCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2020-Topo');

var image = dataset
    .filterDate('2020-01-01', '2021-01-01')
    .filter(ee.Filter.eq('study_area', 'CONUS'))
    .first();

var elevationVisualization = {
  bands: ['Elev'],
  min: -100,
  max: 4500,
  palette: ['00204c', '2a4a84', '4d798e', '7ba66f', 'c9cc57', 'fee838']
};
var aspectVisualization = {
  bands: ['Asp'],
  min: 0,
  max: 360,
  palette: [
    '30123b', '4675ed', '1bcfd4', '61fc6c',
    'd1e834', 'fd8d3c', 'c73e7b', '30123b'
  ]
};

Map.setOptions('TERRAIN');
Map.setCenter(-105.6, 39.2, 7);
Map.addLayer(image, elevationVisualization, 'Elevation (m)');
Map.addLayer(image, aspectVisualization, 'Aspect (degrees)', false);

print('LANDFIRE 2020 CONUS topography image', image);
