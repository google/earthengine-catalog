var dem = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/DEM/001');

var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var dem2021 = dem.filterDate(startDate, endDate);

var soapDTM = dem2021.filter('NEON_SITE == "SOAP"').select('DTM').mosaic();

var palettes = require('users/gena/packages:palettes');
var dem_palette = palettes.colorbrewer.BrBG[9].reverse();

var demVis = {min: 700, max: 2300, palette: dem_palette};

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

var image = soapDTM.visualize(demVis);

Map.addLayer(image, null, 'SOAP 2021 Canopy Height Model (m)');
Map.addLayer(areaOfInterest, {color: 'red'}, 'Area of Interest', false);

print(ui.Thumbnail({image: image, params: visParams}));