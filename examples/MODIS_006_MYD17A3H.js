var dataset = ee.ImageCollection('MODIS/006/MYD17A3H')
                  .filter(ee.Filter.date('2014-01-01', '2014-05-01'));

var npp = dataset.select('Npp');
var nppVis = {
  min: 0.0,
  max: 19000.0,
  palette: ['bbe029', '0a9501', '074b03'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(npp, nppVis, 'NPP');
