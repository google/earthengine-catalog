var dataset = ee.ImageCollection('WRI/GFW/FORMA/vegetation_tstats')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-15'));
var tstat = dataset.select('tstat_r');
var visParams = {
  min: 0.0,
  max: 1.0,
};
Map.setCenter(25.73, -7.61, 2);
Map.addLayer(tstat, visParams, 'Reversed rectified t-statistics');
