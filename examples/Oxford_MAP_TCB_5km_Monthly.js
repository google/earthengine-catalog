var dataset = ee.ImageCollection('Oxford/MAP/TCB_5km_Monthly')
                  .filter(ee.Filter.date('2013-01-01', '2013-12-31'));
var tcb = dataset.select('Mean');
var tcbVis = {
  min: 0.0,
  max: 1.3,
  palette: [
    '011301', '004c00', '056201', '207401', '3e8601', '66a000', '99b718',
    'fcd163', 'ffffff'
  ],
};
Map.setCenter(-44.65, 22.59, 2);
Map.addLayer(tcb, tcbVis, 'TCB');
