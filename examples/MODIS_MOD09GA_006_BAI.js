var dataset = ee.ImageCollection('MODIS/MOD09GA_006_BAI')
                  .filter(ee.Filter.date('2018-04-01', '2018-06-01'));
var scaled = dataset.select('BAI');
var scaledVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(-7.03125, 31.0529339857, 2);
Map.addLayer(scaled, scaledVis, 'Scaled');