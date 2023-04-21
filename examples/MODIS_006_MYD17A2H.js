var dataset = ee.ImageCollection('MODIS/006/MYD17A2H')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var gpp = dataset.select('Gpp');
var gppVis = {
  min: 0.0,
  max: 600.0,
  palette: ['bbe029', '0a9501', '074b03'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(gpp, gppVis, 'GPP');
