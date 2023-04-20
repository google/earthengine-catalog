var dataset = ee.ImageCollection('UMT/NTSG/v2/LANDSAT/GPP')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-31'));
var gpp = dataset.select('GPP');
var gppVis = {
  min: 0.0,
  max: 1000.0,
  palette: ['bbe029', '0a9501', '074b03'],
};
Map.setCenter(-98.26, 39.32, 5);
Map.addLayer(gpp, gppVis, 'GPP');
