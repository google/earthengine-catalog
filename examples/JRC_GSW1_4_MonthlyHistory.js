var dataset = ee.Image('JRC/GSW1_4/MonthlyHistory/2020_06');

var visualization = {
  bands: ['water'],
  min: 0.0,
  max: 2.0,
  palette: ['ffffff', 'fffcb8', '0905ff']
};

Map.setCenter(-121.234, 38.109, 7);

Map.addLayer(dataset, visualization, 'Water');
