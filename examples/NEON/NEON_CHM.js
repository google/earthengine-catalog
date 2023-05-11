var chm = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/DP3-30015-001')

var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var chm2021 = chm.filterDate(startDate, endDate);

var soapSite = chm2021.filter('NEON_SITE == "SOAP"');

// This works well for areas with trees.
var chmVis = {min: 0, max: 35};
Map.addLayer(soapSite, chmVis, 'SOAP 2021 Canopy Height Model (m)');

Map.setCenter(-119.25, 37.06, 12);
