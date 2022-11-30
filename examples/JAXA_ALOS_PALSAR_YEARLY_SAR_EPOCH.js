var dataset = ee.ImageCollection('JAXA/ALOS/PALSAR/YEARLY/SAR_EPOCH')
                  .filter(ee.Filter.date('2017-01-01', '2018-01-01'));
var sarHh = dataset.select('HH');
var sarHhVis = {
  min: 0.0,
  max: 10000.0,
};
Map.setCenter(136.85, 37.37, 4);
Map.addLayer(sarHh, sarHhVis, 'SAR HH');
