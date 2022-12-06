var dataset = ee.ImageCollection('Oxford/MAP/TCW_5km_Monthly')
                  .filter(ee.Filter.date('2013-01-01', '2013-12-31'));
var tcw = dataset.select('Mean');
var tcwVis = {
  min: -0.6,
  max: 0.5,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};
Map.setCenter(-44.65, 22.59, 2);
Map.addLayer(tcw, tcwVis, 'TCW');
