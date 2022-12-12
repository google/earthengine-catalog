var dataset = ee.ImageCollection('JRC/GSW1_0/MonthlyHistory')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var water = dataset.select('water');
var waterVis = {
  min: 0.0,
  max: 2.0,
  palette: ['ffffff', 'fffcb8', '0905ff'],
};
Map.setCenter(-58.999, -3.373, 7);
Map.addLayer(water, waterVis, 'Water');
