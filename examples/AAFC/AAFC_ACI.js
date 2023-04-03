var dataset = ee.ImageCollection('AAFC/ACI');
var crop2016 = dataset
    .filter(ee.Filter.date('2016-01-01', '2016-12-31'))
    .first();
Map.setCenter(-103.8881, 53.0371, 10);
Map.addLayer(crop2016);
