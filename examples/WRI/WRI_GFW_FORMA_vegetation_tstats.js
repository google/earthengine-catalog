var dataset = ee.ImageCollection('WRI/GFW/FORMA/vegetation_tstats')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-15'));
var tstat = dataset.select('tstat_r');
var visParams = {
  min: 0,
  max: 1,
};
Map.setCenter(26, -8, 3);
Map.addLayer(tstat, visParams, 'Reversed rectified t-statistics');
