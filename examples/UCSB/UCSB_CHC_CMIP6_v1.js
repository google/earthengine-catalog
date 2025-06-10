var dataset = ee.ImageCollection('UCSB/CHC/CMIP6/v1')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var chirps = dataset.select('CHIRPS');
var chirpsVis = {
  min: 0,
  max: 100.0,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
};
Map.setCenter(93.17, 10.14, 4);
Map.addLayer(chirps, chirpsVis, 'CHC CMIP6');