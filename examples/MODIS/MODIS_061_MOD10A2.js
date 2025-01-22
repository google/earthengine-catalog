var dataset = ee.ImageCollection('MODIS/061/MOD10A2')
  .filter(ee.Filter.date('2023-01-01', '2023-12-01'))
  .select('Maximum_Snow_Extent');

var visualization = {
  min: 50.0,
  max: 200.0,
  palette: [
    '000000',
    '0dffff',
    '0524ff',
    'ffffff'
  ]
};


Map.setCenter(-3.69, 65.99, 4);

Map.addLayer(dataset.mean(), visualization, 'Maximum_Snow_Extent');