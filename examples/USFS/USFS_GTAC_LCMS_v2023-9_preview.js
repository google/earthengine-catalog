var dataset = ee.ImageCollection('USFS/GTAC/LCMS/v2023-9');

var lcms = dataset.filter(ee.Filter.calendarRange(2022, 2022,'year'))  // range: [1985, 2023]
               .filter('study_area == "CONUS"').first()  // or "SEAK"; "PRUSVI"; "HAWAII"

var landCover = lcms.select('Land_Cover');
var image = landCover.visualize();

var lon = -96;
var lat = 38;

Map.setCenter(lon, lat, 3);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Degrees in EPSG:3857
var lonDelta = 30;
var latDelta = 21.5;
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

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, null, 'Land Cover with background');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
