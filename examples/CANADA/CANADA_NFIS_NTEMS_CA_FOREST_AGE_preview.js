var dataset = ee.ImageCollection('CANADA/NFIS/NTEMS/CA_FOREST_AGE');
var primary_forest = dataset.select('forest').mean();

var lon = -107.94;
var lat = 58.18;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 4);

// Degrees in EPSG:4326
var delta = 20;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var image = primary_forest.visualize(
    {palette: ['006600', '002200', 'fff700', 'ab7634', 'c4d0ff', 'ffffff']});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Canadian Primary Forest');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
