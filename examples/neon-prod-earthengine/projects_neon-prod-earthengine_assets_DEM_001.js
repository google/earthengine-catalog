var dem = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/DEM/001');
  
var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var dem2021 = dem.filterDate(startDate, endDate);
  
var soapSite = dem2021.filter('NEON_SITE == "SOAP"');
  
var soapDTM = dem2021.select('DTM');
var soapDSM = dem2021.select('DSM');

var palettes = require('users/gena/packages:palettes');
var dem_palette = palettes.colorbrewer.BrBG[9].reverse();
  
var demVis = {min: 700, max: 2300, palette: dem_palette};
Map.addLayer(soapDTM, demVis, 'SOAP 2021 Digital Terrain Model (m)');
Map.addLayer(soapDSM, demVis, 'SOAP 2021 Digital Surface Model (m)');
  
Map.setCenter(-119.25, 37.06, 12);

