var dataset = ee.ImageCollection('MODIS/061/MOD16A2GF')
                  .filter(ee.Filter.date('2022-01-01', '2022-05-01'));
var evapotranspiration = dataset.select('ET');
var evapotranspirationVis = {
  min: 0,
  max: 300,
  palette: [
    'ffffff', 'fcd163', '99b718', '66a000', '3e8601', '207401', '056201',
    '004c00', '011301'
  ],
};
Map.setCenter(0, 0, 2);
Map.addLayer(evapotranspiration, evapotranspirationVis, 'Evapotranspiration');
