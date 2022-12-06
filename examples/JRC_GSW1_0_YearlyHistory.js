var dataset = ee.ImageCollection('JRC/GSW1_0/YearlyHistory')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var waterClass = dataset.select('waterClass');
var waterClassVis = {
  min: 0.0,
  max: 3.0,
  palette: ['cccccc', 'ffffff', '99d9ea', '0000ff'],
};
Map.setCenter(59.414, 45.182, 7);
Map.addLayer(waterClass, waterClassVis, 'Water Class');
