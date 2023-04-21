var dataset = ee.ImageCollection('UMT/NTSG/v2/MODIS/NPP')
                  .filter(ee.Filter.date('2016-01-01', '2016-12-31'));
var npp = dataset.select('annualNPP');
var nppVis = {
  min: 0.0,
  max: 20000.0,
  palette: ['bbe029', '0a9501', '074b03'],
};
Map.setCenter(-98.26, 39.32, 5);
Map.addLayer(npp, nppVis, 'NPP');
