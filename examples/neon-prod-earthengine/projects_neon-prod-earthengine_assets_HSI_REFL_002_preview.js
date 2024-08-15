var refl002 = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/HSI_REFL/002');

var startDate = ee.Date('2022-01-01');
var endDate = startDate.advance(1, 'year');
var refl002_2022 = refl002.filterDate(startDate, endDate);

var liro2022 = refl002_2022.filter('NEON_SITE == "LIRO"').mosaic();
var liro2022_rgb = liro2022.select(['B053', 'B035', 'B019'])

var lon = -89.7024;
var lat = 46.005;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:3857.
var delta = 0.015;
// Width and Height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  min: 128, max: 133,
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var image = liro2022_rgb.visualize();
var imageClip = liro2022_rgb.visualize().clip(areaOfInterest);

Map.addLayer(image, {min: 128, max: 133}, 'LIRO 2022 Bidirectional Reflectance RGB Image');

Map.addLayer(areaOfInterest, {color: 'red', opacity: 0.5}, 'Area of Interest');

print(ui.Thumbnail({image: imageClip, params: visParams}));
