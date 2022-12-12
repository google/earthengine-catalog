var dataset = ee.ImageCollection('JRC/GSW1_0/MonthlyRecurrence').first();
var monthlyRecurrence = dataset.select('monthly_recurrence');
var monthlyRecurrenceVis = {
  min: 0.0,
  max: 100.0,
  palette: ['ffffff', 'ffbbbb', '0000ff'],
};
Map.setCenter(-51.482, -0.835, 9);
Map.addLayer(monthlyRecurrence, monthlyRecurrenceVis, 'Monthly Recurrence');
