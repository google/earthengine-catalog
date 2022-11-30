var dataset = ee.ImageCollection('MODIS/006/MOD16A2')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var evapotranspiration = dataset.select('ET');
var evapotranspirationVis = {
  min: 0.0,
  max: 300.0,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(evapotranspiration, evapotranspirationVis, 'Evapotranspiration');
