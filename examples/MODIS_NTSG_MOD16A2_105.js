var dataset = ee.ImageCollection('MODIS/NTSG/MOD16A2/105')
                  .filter(ee.Filter.date('2014-04-01', '2014-06-01'));
var evapotranspiration = dataset.select('ET');
var evapotranspirationVis = {
  min: 0.0,
  max: 300.0,
  palette:
      ['a50000', 'ff4f1a', 'f1e342', 'c7ef1f', '05fff3', '1707ff', 'd90bff'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(evapotranspiration, evapotranspirationVis, 'Evapotranspiration');
