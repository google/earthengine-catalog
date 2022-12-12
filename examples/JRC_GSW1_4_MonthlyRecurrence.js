var dataset = ee.ImageCollection('JRC/GSW1_4/MonthlyRecurrence');

var visualization = {
  bands: ['monthly_recurrence'],
  min: 0.0,
  max: 100.0,
  palette: ['ffffff', 'ffbbbb', '0000ff']
};

Map.setCenter(-51.482, -0.835, 6);

Map.addLayer(dataset, visualization, 'Monthly Recurrence');
