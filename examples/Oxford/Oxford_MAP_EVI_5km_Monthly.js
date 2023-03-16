var dataset = ee.ImageCollection('Oxford/MAP/EVI_5km_Monthly')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var evi = dataset.select('Mean');
var eviVis = {
  min: 0.0,
  max: 1.0,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};
Map.setCenter(-60.5, -20.0, 2);
Map.addLayer(evi, eviVis, 'EVI');
