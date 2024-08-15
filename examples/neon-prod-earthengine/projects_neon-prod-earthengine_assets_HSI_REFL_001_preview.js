var sdr = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/HSI_REFL/001');

var startDate = ee.Date('2017-01-01');
var endDate = startDate.advance(1, 'year');
var sdr2017 = sdr.filterDate(startDate, endDate);

var grsm2017 = sdr2017.filter('NEON_SITE == "GRSM"').mosaic();
var grsm_rgb = grsm2017.select(['B053', 'B035', 'B019'])

//center on burn scar from 2016 Chimney Tops fire
var lon = -83.5;
var lat = 35.65;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:3857.
var delta = 0.045;
// Width and Height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  min: 128, max: 133,
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var image = grsm_rgb.visualize();
var imageClip = grsm_rgb.visualize().clip(areaOfInterest);

Map.addLayer(image, {min: 128, max: 133}, 'GRSM 2017 Directional Reflectance RGB Image');

Map.addLayer(areaOfInterest, {color: 'red', opacity: 0.5}, 'Area of Interest');

print(ui.Thumbnail({image: imageClip, params: visParams}));
