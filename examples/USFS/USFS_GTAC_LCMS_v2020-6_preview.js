var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2020-6');

var lcms =
    dataset
        .filterDate('2020', '2021')        // range: [1985, 2020]
        .filter('study_area == "PRUSVI"')  // Puerto Rico only in this version.
        .first();

var landCover = lcms.select('Land_Use');
var image = landCover.visualize();

var lon = -65.616;
var lat = 18.161;

Map.setCenter(lon, lat, 11);

// cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});

// Degrees in EPSG:3857
var lonDelta = 0.35;
var latDelta = 0.35;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - latDelta, lon + lonDelta, lat + latDelta],
    null,
    false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(
    imageWithBackground, null, 'Land Cover with background', true, 0.5);

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
