var dataset = ee.ImageCollection('NOAA/CDR/AVHRR/NDVI/V5')
                  .filter(ee.Filter.date('2018-05-01', '2018-06-01'));
var ndvi = dataset.select('NDVI');
var ndviVis = {
  min: -1000.0,
  max: 5000.0,
  palette: [
    'ffffff', 'ce7e45', 'fcd163', 'c6ca02', '22cc04', '99b718', '207401',
    '012e01'
  ],
};
Map.setCenter(7.71, 17.93, 2);
Map.addLayer(ndvi, ndviVis, 'NDVI');
