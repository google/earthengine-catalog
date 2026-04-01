var soc = ee.Image('USDA/SOLUS100/V0/soc');
// NOTE: The following is equivalent:
// var soc = ee.ImageCollection('USDA/SOLUS100/V0')
//   .filter(ee.Filter.eq('system:index', 'soc'))
//   .first();
var soc_0_cm_p = soc.select('r_0_cm_p');

var visParams = {
  min: 0,
  max: 2000,
  palette: ['fff7bc', 'fee391', 'fec44f', 'fe9929', 'ec7014', 'cc4c02', '993404'],
};

Map.setCenter(-95, 38, 4);
Map.addLayer(soc_0_cm_p, visParams, 'Soil Organic Carbon 0-5cm');
