var dataset = ee.ImageCollection('JRC/GSW1_3/YearlyHistory');

var visualization = {
  bands: ['waterClass'],
  min: 0.0,
  max: 3.0,
  palette: ['cccccc', 'ffffff', '99d9ea', '0000ff']
};

Map.setCenter(59.414, 45.182, 7);

Map.addLayer(dataset, visualization, 'Water Class');
