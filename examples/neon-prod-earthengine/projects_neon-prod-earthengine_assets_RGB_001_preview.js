var rgb = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/RGB/001');

var startDate = ee.Date('2021-01-01');
var endDate = startDate.advance(1, 'year');
var rgb2021 = rgb.filterDate(startDate, endDate);

var abbySite = rgb2021.filter('NEON_SITE == "ABBY"').mosaic();

var lon = -122.341;
var lat = 45.75;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:3857.
var delta = 0.02;
// Width and Height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var vis = {min: 60, max: 200};

var image = abbySite.visualize(vis);
var imageClip = abbySite.visualize(vis).clip(areaOfInterest);

Map.addLayer(image, null, 'ABBY 2021 RGB Camera Imagery (m)');

Map.addLayer(areaOfInterest, {color: 'red', opacity: 0.1}, 'Area of Interest');

print(ui.Thumbnail({image: imageClip, params: visParams}));
