var dataset = ee.Image('JRC/GSW1_3/GlobalSurfaceWater');

var visualization = {
  bands: ['occurrence'],
  min: 0.0,
  max: 100.0,
  palette: ['ffffff', 'ffbbbb', '0000ff']
};

Map.setCenter(59.414, 45.182, 6);

Map.addLayer(dataset, visualization, 'Occurrence');
