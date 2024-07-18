var dataset = ee.ImageCollection('MODIS/061/MOD17A2HGF')
                  .filter(ee.Filter.date('2021-01-01', '2021-05-01'));

var gpp = dataset.select('Gpp');
var gppVis = {
  min: 0,
  max: 600,
  palette: ['bbe029', '0a9501', '074b03'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(gpp, gppVis, 'GPP');
