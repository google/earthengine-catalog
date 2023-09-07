// Import the NLCD RCMAP TRENDS image.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/NLCD');

// Filter the collection to the 2021 product.
var nlcd2021 = dataset.filter(ee.Filter.eq('system:index', '2021')).first();

// Select to the landcover band
var landcover = nlcd2021.select('landcover');

var palette = [
  // landcover values
   //'palette': [
    '466b9f', // 11: Open water
    'd1def8', // 12: Perennial ice/snow
    'dec5c5', // 21: Developed, open space
    'd99282', // 22: Developed, low intensity
    'eb0000', // 23: Developed, medium intensity
    'ab0000', // 24: Developed high intensity
    'b3ac9f', // 31: Barren land (rock/sand/clay)
    '68ab5f', // 41: Deciduous forest
    '1c5f2c', // 42: Evergreen forest
    'b5c58f', // 42: Mixed forest
    'ccb879', // 52: Shrub/scrub
    'dfdfc2', // 71: Grassland/herbaceous
    'dcd939', // 81: Pasture/hay
    'ab6c28', // 82: Cultivated crops
    'b8d9eb', // 90: Woody wetlands
    '6c9fb8', // 95: Emergent herbaceous wetlands
   ];
//};

// Map landcover pixel values onto palette indices.
var landcover_values = ee.List([
  11, 12, 21, 22, 23, 24, 31, 41, 42, 43, 52, 71, 81, 82, 90, 95
]);
var max = landcover_values.size().subtract(1);
var landcover_indices = ee.List.sequence(0, max);

var lon = -95;
var lat = 36;

Map.setCenter(lon, lat, 5);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// Degrees in EPSG:3857.
var delta = 14.5;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var image = landcover.visualize();
Map.addLayer(image)

var imageWithBackground = ee.ImageCollection([waterLandBackground, image]).mosaic();
Map.addLayer(imageWithBackground, null, 'landcover');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));