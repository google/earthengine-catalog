var dataset = ee.ImageCollection('NASA/GIMMS/3GV0')
                  .filter(ee.Filter.date('2013-06-01', '2013-12-31'));
var ndvi = dataset.select('ndvi');
var ndviVis = {
  min: -1.0,
  max: 1.0,
  palette: ['000000', 'f5f5f5', '119701'],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(ndvi, ndviVis, 'NDVI');
