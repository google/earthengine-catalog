var dataset = ee.ImageCollection('USFS/GTAC/TreeMap/v2016');

var tm2016 = dataset.filterDate('2016', '2017').first();

var fldtypcd = tm2016.select('FLDTYPCD');

var image = fldtypcd.visualize();

var lon = -115;
var lat = 40;

Map.setCenter(lon, lat, 4);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var backgroundPalette = ['87adca', 'e8e2d5'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Degrees in EPSG:3857
var lonDelta = 10;
var latDelta = 10;
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

Map.addLayer(imageWithBackground, null, 'FLDTYPCD with background');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
