var chm = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/CHM/001');

var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var chm2021 = chm.filterDate(startDate, endDate);

var soapSite = chm2021.filter('NEON_SITE == "SOAP"').mosaic();

// This works well for areas with trees.
var chmVis = {min: 0, max: 35, palette: ['E6F7E0', '063B00']};

var lon = -119.25;
var lat = 37.06;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:3857.
var delta = 0.045;
// Width and Height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var image = soapSite.visualize(chmVis);

Map.addLayer(image, null, 'SOAP 2021 Canopy Height Model (m)');
Map.addLayer(areaOfInterest, {color: 'red'}, 'Area of Interest', false);

print(ui.Thumbnail({image: image, params: visParams}));
