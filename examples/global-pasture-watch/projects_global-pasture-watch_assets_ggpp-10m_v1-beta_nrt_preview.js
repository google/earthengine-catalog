var lon = -55.50;
var lat = -12.20;

var collection = ee.ImageCollection(
    'projects/global-pasture-watch/assets/ggpp-10m/v1-beta/nrt'
).filterDate('2026-06-27', '2026-09-20');

// The 'ugpp' band stores uGPP scaled by 10 (16-bit integers) with no-data = -1.
var ugpp = collection.map(function(image) {
  return image.select('ugpp')
      .updateMask(image.select('ugpp').neq(-1))
      .multiply(0.1)
      .rename('ugpp_gC_m2_day');
}).median();

var palette = ['faccfa', 'f19d6b', '828232', '226061', '011959'];
var vis = {min: 0, max: 3, palette: palette};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var visualizedImage = ugpp.visualize(vis);
var imageWithBackground = ee.ImageCollection([background, visualizedImage]).mosaic();

Map.setCenter(lon, lat, 11);
Map.addLayer(imageWithBackground, {}, 'uGPP');

var delta = 0.09;
var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
